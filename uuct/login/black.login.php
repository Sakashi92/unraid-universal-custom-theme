<?php
// Included in login.php

// Only start a session to check if they have a cookie that looks like our session
$server_name = strtok($_SERVER['HTTP_HOST'],":");
if (!empty($_COOKIE['unraid_'.md5($server_name)])) {
    // Start the session so we can check if $_SESSION has data
    session_start();

    // Check if the user is already logged in
    if ($_SESSION && !empty($_SESSION['unraid_user'])) {
        // If so redirect them to the start page
        header("Location: /".$var['START_PAGE']);
        exit;
    }
}

function readFromFile($file): string {
    $text = "";
    if (file_exists($file)) {
        $fp = fopen($file,"r");
        if (flock($fp, LOCK_EX)) {
            $text = fread($fp, filesize($file));
            flock($fp, LOCK_UN);
            fclose($fp);
        }
    }
    return $text;
}

function appendToFile($file, $text): void {
    $fp = fopen($file,"a");
    if (flock($fp, LOCK_EX)) {
        fwrite($fp, $text);
        fflush($fp);
        flock($fp, LOCK_UN);
        fclose($fp);
    }
}

function writeToFile($file, $text): void {
    $fp = fopen($file,"w");
    if (flock($fp, LOCK_EX)) {
        fwrite($fp, $text);
        fflush($fp);
        flock($fp, LOCK_UN);
        fclose($fp);
    }
}

// Source: https://stackoverflow.com/a/2524761
function isValidTimeStamp($timestamp)
{
    return ((string) (int) $timestamp === $timestamp)
        && ($timestamp <= PHP_INT_MAX)
        && ($timestamp >= ~PHP_INT_MAX);
}

function cleanupFails(string $failFile, int $time): int {
    global $cooldown;

    // Read existing fails
    @mkdir(dirname($failFile), 0755);
    $failText = readFromFile($failFile);
    $fails = explode("\n", trim($failText));

    // Remove entries older than $cooldown minutes, and entries that are not timestamps
    $updateFails = false;
    foreach ((array) $fails as $key => $value) {
        if ( !isValidTimeStamp($value) || ($time - $value > $cooldown) || ($value > $time) ) {
            unset ($fails[$key]);
            $updateFails = true;
        }
    }

    // Save fails to disk
    if ($updateFails) {
        $failText = implode("\n", $fails)."\n";
        writeToFile($failFile, $failText);
    }
    return count($fails);
}

function verifyUsernamePassword(string $username, string $password): bool {
    if ($username != "root") return false;

    $output = exec("/usr/bin/getent shadow $username");
    if ($output === false) return false;
    $credentials = explode(":", $output);
    return password_verify($password, $credentials[1]);
}

function verifyTwoFactorToken(string $username, string $token): bool {
    try {
        // Create curl client
        $curlClient = curl_init();
        curl_setopt($curlClient, CURLOPT_HEADER, true);
        curl_setopt($curlClient, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curlClient, CURLOPT_UNIX_SOCKET_PATH, '/var/run/unraid-api.sock');
        curl_setopt($curlClient, CURLOPT_URL, 'http://unixsocket/verify');
        curl_setopt($curlClient, CURLOPT_BUFFERSIZE, 256);
        curl_setopt($curlClient, CURLOPT_TIMEOUT, 5);
        curl_setopt($curlClient, CURLOPT_HTTPHEADER, array('Content-Type:application/json', 'Origin: /var/run/unraid-notifications.sock'));
        curl_setopt($curlClient, CURLOPT_POSTFIELDS, json_encode([
            'username' => $username,
            'token' => $token
        ]));

        // Send the request
        curl_exec($curlClient);

        // Get the http status code
        $httpCode = curl_getinfo($curlClient, CURLINFO_HTTP_CODE);

        // Close the connection
        curl_close($curlClient);

        // Error
        // This should accept 200 or 204 status codes
        if ($httpCode !== 200 && $httpCode !== 204) {
            // Log error to syslog
            exec("logger -t webGUI ".escapeshellarg("2FA code for {$username} is invalid, blocking access!"));
            return false;
        }

        // Log success to syslog
        exec("logger -t webGUI ".escapeshellarg("2FA code for {$username} is valid, allowing login!"));

        // Success
        return true;
    } catch (Exception $exception) {
        // Error
        return false;
    }
}

// Check if a haystack ends in a needle
function endsWith($haystack, $needle): bool {
    return substr_compare($haystack, $needle, -strlen($needle)) === 0;
}

// Check if we're accessing this via a wildcard cert
function isWildcardCert(): bool {
    global $server_name;
    return endsWith($server_name, '.myunraid.net');
}

// Check if we're accessing this locally via the expected myunraid.net url
function isLocalAccess(): bool {
    global $nginx, $server_name;
    return isWildcardCert() && $nginx['NGINX_LANFQDN'] === $server_name;
}

// Check if we're accessing this remotely via the expected myunraid.net url
function isRemoteAccess(): bool {
    global $nginx, $server_name;
    return isWildcardCert() && $nginx['NGINX_WANFQDN'] === $server_name;
}

// Check if 2fa is enabled for local (requires USE_SSL to be "auto" so no alternate urls can access the server)
function isLocalTwoFactorEnabled(): bool {
    global $nginx, $my_servers;
    return $nginx['NGINX_USESSL'] === "auto" && $my_servers['local']['2Fa'] === 'yes';
}

// Check if 2fa is enabled for remote
function isRemoteTwoFactorEnabled(): bool {
    global $my_servers;
    return $my_servers['remote']['2Fa'] === 'yes';
}

// Load configs into memory
$my_servers = @parse_ini_file('/boot/config/plugins/dynamix.my.servers/myservers.cfg', true);
$nginx = @parse_ini_file('/var/local/emhttp/nginx.ini');

// Vars
$maxFails = 3;
$cooldown = 15 * 60; // 15 mins
$remote_addr = $_SERVER['REMOTE_ADDR'] ?? "unknown";
$failFile = "/var/log/pwfail/{$remote_addr}";

// Get the credentials
$username = $_POST['username'];
$password = $_POST['password'];
$token = $_REQUEST['token'];

// Check if we need 2fa
$twoFactorRequired = (isLocalAccess() && isLocalTwoFactorEnabled()) || (isRemoteAccess() && isRemoteTwoFactorEnabled());

// If we have a username + password combo attempt to login
if (!empty($username) && !empty($password)) {
    try {
        // Bail if we're missing the 2FA token and we expect one
        if (isWildcardCert() && $twoFactorRequired && empty($token)) throw new Exception(_('No 2FA token detected'));

        // Read existing fails, cleanup expired ones
        $time = time();
        $failCount = cleanupFails($failFile, $time);

        // Check if we're limited
        if ($failCount >= $maxFails) {
            if ($failCount == $maxFails) exec("logger -t webGUI ".escapeshellarg("Ignoring login attempts for {$username} from {$remote_addr}"));
            throw new Exception(_('Too many invalid login attempts'));
        }

        // Bail if username + password combo doesn't work
        if (!verifyUsernamePassword($username, $password)) throw new Exception(_('Invalid username or password'));

        // Bail if we need a token but it's invalid
        if (isWildcardCert() && $twoFactorRequired && !verifyTwoFactorToken($username, $token)) throw new Exception(_('Invalid 2FA token'));

        // Successful login, start session
        @unlink($failFile);
        session_start();
        $_SESSION['unraid_login'] = time();
        $_SESSION['unraid_user'] = $username;
        session_regenerate_id(true);
        session_write_close();
        exec("logger -t webGUI ".escapeshellarg("Successful login user {$username} from {$remote_addr}"));

        // Redirect the user to the start page
        header("Location: /".$var['START_PAGE']);
        exit;
    } catch (Exception $exception) {
        // Set error message
        $error = $exception->getMessage();

        // Log error to syslog
        exec("logger -t webGUI ".escapeshellarg("Unsuccessful login user {$username} from {$remote_addr}"));
        appendToFile($failFile, $time."\n");
    }
}

$boot   = "/boot/config/plugins/dynamix";
$myFile = "case-model.cfg";
$myCase = file_exists("$boot/$myFile") ? file_get_contents("$boot/$myFile") : false;

extract(parse_plugin_cfg('dynamix', true));
$theme_dark = in_array($display['theme'], ['black', 'gray']);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <meta http-equiv="Content-Security-Policy" content="block-all-mixed-content">
    <meta name="referrer" content="same-origin">
    <title><?=$var['NAME']?>/Login</title>
    <link rel='stylesheet' href='/boot/extra/theme/login_raphtalia.css'>
    <style>
    /************************
    /
    /  Fonts
    /
    /************************/
    @font-face{font-family:clear-sans;font-weight:normal;font-style:normal; src:url('/webGui/styles/clear-sans.woff?20220513') format('woff')}
    @font-face{font-family:clear-sans;font-weight:bold;font-style:normal; src:url('/webGui/styles/clear-sans-bold.woff?20220513') format('woff')}
    @font-face{font-family:clear-sans;font-weight:normal;font-style:italic; src:url('/webGui/styles/clear-sans-italic.woff?20220513') format('woff')}
    @font-face{font-family:clear-sans;font-weight:bold;font-style:italic; src:url('/webGui/styles/clear-sans-bold-italic.woff?20220513') format('woff')}
    @font-face{font-family:bitstream;font-weight:normal;font-style:normal; src:url('/webGui/styles/bitstream.woff?20220513') format('woff')}
    @font-face{font-family:bitstream;font-weight:bold;font-style:normal; src:url('/webGui/styles/bitstream-bold.woff?20220513') format('woff')}
    @font-face{font-family:bitstream;font-weight:normal;font-style:italic; src:url('/webGui/styles/bitstream-italic.woff?20220513') format('woff')}
    @font-face{font-family:bitstream;font-weight:bold;font-style:italic; src:url('/webGui/styles/bitstream-bold-italic.woff?20220513') format('woff')}

    /************************
    /
    /  General styling
    /
    /************************/
    body {
        background: <?=$theme_dark?'#0d0d0d':'#0d0d0d'?>;
        color: <?=$theme_dark?'#fff':'#1c1b1b'?>;
        font-family: clear-sans, sans-serif;
        font-size: .875rem;
        padding: 0;
        margin: 0;
    }
    a {
        text-transform: uppercase;
        font-weight: bold;
        letter-spacing: 2px;
        color: #FF8C2F;
        text-decoration: none;
    }
    a:hover {
        color: #f15a2c;
    }
    h1 {
        font-size: 1.8em;
        margin: 0;
    }
    h2 {
        font-size: 0.8em;
        margin-top: 0;
        margin-bottom: 1.8em;
    }
    .button {
        color: #ff8c2f;
        font-family: clear-sans, sans-serif;
        background: -webkit-gradient(linear,left top,right top,from(#e03237),to(#fd8c3c)) 0 0 no-repeat,-webkit-gradient(linear,left top,right top,from(#e03237),to(#fd8c3c)) 0 100% no-repeat,-webkit-gradient(linear,left bottom,left top,from(#e03237),to(#e03237)) 0 100% no-repeat,-webkit-gradient(linear,left bottom,left top,from(#fd8c3c),to(#fd8c3c)) 100% 100% no-repeat;
        background: linear-gradient(90deg,#e03237 0,#fd8c3c) 0 0 no-repeat,linear-gradient(90deg,#e03237 0,#fd8c3c) 0 100% no-repeat,linear-gradient(0deg,#e03237 0,#e03237) 0 100% no-repeat,linear-gradient(0deg,#fd8c3c 0,#fd8c3c) 100% 100% no-repeat;
        background-size: 100% 2px,100% 2px,2px 100%,2px 100%;
    }
    .button:hover {
        color: #fff;
        background-color: #f15a2c;
        background: -webkit-gradient(linear,left top,right top,from(#e22828),to(#ff8c2f));
        background: linear-gradient(90deg,#e22828 0,#ff8c2f);
        -webkit-box-shadow: none;
        box-shadow: none;
        cursor: pointer;
    }
    .button--small {
        font-size: .875rem;
        font-weight: 600;
        line-height: 1;
        text-transform: uppercase;
        letter-spacing: 2px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        background-color: transparent;
        border-radius: .125rem;
        border: 0;
        -webkit-transition: none;
        transition: none;
        padding: .75rem 1.5rem;
    }
    [type=email], [type=number], [type=password], [type=search], [type=tel], [type=text], [type=url], textarea {
        font-family: clear-sans, sans-serif;
        font-size: .875rem;
        background-color: #F2F2F2;
        width: 100%;
        margin-bottom: 1rem;
        border: 2px solid #ccc;
        padding: .75rem 1rem;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        border-radius: 0;
        -webkit-appearance: none;
    }
    [type=email]:active, [type=email]:focus, [type=number]:active, [type=number]:focus, [type=password]:active, [type=password]:focus, [type=search]:active, [type=search]:focus, [type=tel]:active, [type=tel]:focus, [type=text]:active, [type=text]:focus, [type=url]:active, [type=url]:focus, textarea:active, textarea:focus {
        border-color: #ff8c2f;
        outline: none;
    }

    /************************
    /
    /  Login specific styling
    /
    /************************/
    #login {
        width: 500px;
        margin: 6rem auto;
        border-radius: 10px;
        background: <?=$theme_dark?'#000000':'#000000'?>;
    }
    #login::after {
        content: "";
        clear: both;
        display: table;
    }
    #login .logo {
        position: relative;
        overflow: hidden;
        height: 120px;
        border-radius: 10px 10px 0 0;
    }
    #login .wordmark {
        z-index: 1;
        position: relative;
        padding: 2rem;
    }
    #login .wordmark svg {
        width: 100px;
    }
    #login .case {
        float: right;
        width: 30%;
        font-size: 6rem;
        text-align: center;
    }
    #login .case img {
        max-width: 96px;
        max-height: 96px;
    }
    #login .error {
        color: red;
        margin-top: -20px;
    }
    #login .content {
        padding: 2rem;
    }
    #login .form {
        width: 65%;
    }
    .angle:after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 120px;
        background-color: #f15a2c;
        background: -webkit-gradient(linear,left top,right top,from(#e22828),to(#ff8c2f));
        background: linear-gradient(90deg,#e22828 0,#ff8c2f);
        -webkit-transform-origin: bottom left;
        transform-origin: bottom left;
        -webkit-transform: skewY(-6deg);
        transform: skewY(-6deg);
        -webkit-transition: -webkit-transform .15s linear;
        transition: -webkit-transform .15s linear;
        transition: transform .15s linear;
        transition: transform .15s linear,-webkit-transform .15s linear;
    }
    .shadow {
        -webkit-box-shadow: 0 2px 8px 0 rgba(0,0,0,.12);
        box-shadow: 0 2px 8px 0 rgba(0,0,0,.12);
    }
    .hidden { display: none; }
    /************************
    /
    /  Cases
    /
    /************************/
    [class^="case-"], [class*=" case-"] {
        /* use !important to prevent issues with browser extensions that change fonts */
        font-family: 'cases' !important;
        speak: none;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;

        /* Better Font Rendering =========== */
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    /************************
    /
    /  Media queries for mobile responsive
    /
    /************************/
    @media (max-width: 500px) {
        body {
            background: <?=$theme_dark?'#000000':'#000000'?>;
        }
        [type=email], [type=number], [type=password], [type=search], [type=tel], [type=text], [type=url], textarea {
            font-size: 16px; /* This prevents the mobile browser from zooming in on the input-field. */
        }
        #login {
            margin: 0;
            border-radius: 0;
            width: 100%;
        }
        #login .logo {
            border-radius: 0;
        }
        .shadow {
            box-shadow: none;
        }
    }
    </style>
    <link type="text/css" rel="stylesheet" href="<?autov("/webGui/styles/default-cases.css")?>">
    <link type="image/png" rel="shortcut icon" href="/webGui/images/<?=$var['mdColor']?>.png">
</head>

<body>
    <section id="login" class="shadow">
        <div class="logo angle">
            <div class="wordmark"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 222.4 39" class="Nav__logo--white"><path fill="#ffffff" d="M146.70000000000002 29.5H135l-3 9h-6.5L138.9 0h8l13.4 38.5h-7.1L142.6 6.9l-5.8 16.9h8.2l1.7 5.7zM29.7 0v25.4c0 8.9-5.8 13.6-14.9 13.6C5.8 39 0 34.3 0 25.4V0h6.5v25.4c0 5.2 3.2 7.9 8.2 7.9 5.2 0 8.4-2.7 8.4-7.9V0h6.6zM50.9 12v26.5h-6.5V0h6.1l17 26.5V0H74v38.5h-6.1L50.9 12zM171.3 0h6.5v38.5h-6.5V0zM222.4 24.7c0 9-5.9 13.8-15.2 13.8h-14.5V0h14.6c9.2 0 15.1 4.8 15.1 13.8v10.9zm-6.6-10.9c0-5.3-3.3-8.1-8.5-8.1h-8.1v27.1h8c5.3 0 8.6-2.8 8.6-8.1V13.8zM108.3 23.9c4.3-1.6 6.9-5.3 6.9-11.5 0-8.7-5.1-12.4-12.8-12.4H88.8v38.5h6.5V5.7h6.9c3.8 0 6.2 1.8 6.2 6.7s-2.4 6.8-6.2 6.8h-3.4l9.2 19.4h7.5l-7.2-14.7z"></path></svg></div>
        </div>
        <div class="content">
            <h1>
               	<?=$var['COMMENT']?>
            </h1>

            <div class="case">
            <?if ($myCase):?>
                <?if (substr($myCase,-4)!='.png'):?>
                <span class='case-<?=$myCase?>'></span>
                <?else:?>
                <img src='<?=autov("/webGui/images/$myCase")?>'>
                <?endif;?>
            <?endif;?>
            </div>

            <div class="form">
                <form class="js-removeTimeout" action="/login" method="POST">
                    <? if (($twoFactorRequired && $token) || !$twoFactorRequired) { ?>
                        <p>
                            <input name="username" type="text" placeholder="<?=_('Username')?>" autocapitalize="none" autocomplete="off" spellcheck="false" autofocus required>
                            <input name="password" type="password" placeholder="<?=_('Password')?>" required>
                            <input name="token" type="hidden" value="<?= $token ?>">
                        </p>
                        <? if ($error) echo "<p class='error'>$error</p>"; ?>
                        <p>
                            <button type="submit" class="button button--small"><?=_('Login')?></button>
                        </p>
                    <? } else { ?>
                        <? if ($error) { ?>
                            <div>
                                <p class="error" style="padding-top:10px;"><?= $error ?></p>
                            </div>
                        <? } else { ?>
                            <div>
                                <p class="error" style="padding-top:10px;" title="<?= _('Please access this server via the My Servers Dashboard') ?>"><?= _('No 2FA token detected') ?></p>
                            </div>
                        <? } ?>
                        <div>
                            <a href="https://forums.unraid.net/my-servers/" class="button button--small" title="<?=_('Go to My Servers Dashboard')?>"><?=_('Go to My Servers Dashboard')?></a>
                        </div>
                    <? } ?>
                    <script type="text/javascript">
                        document.cookie = "cookietest=1";
                        cookieEnabled = document.cookie.indexOf("cookietest=")!=-1;
                        document.cookie = "cookietest=1; expires=Thu, 01-Jan-1970 00:00:01 GMT";
                        if (!cookieEnabled) {
                            document.write("<p class='error'><?=_('Browser cookie support required for Unraid OS webgui')?></p>");
                        }
                    </script>
                </form>

                <? if (($twoFactorRequired && $token) || !$twoFactorRequired) { ?>
                    <div class="js-addTimeout hidden">
                        <p class="error" style="padding-top:10px;"><?=_('Transparent 2FA Token timed out')?></p>
                        <a href="https://forums.unraid.net/my-servers/" class="button button--small" title="<?=_('Go to My Servers Dashboard')?>"><?=_('Go to My Servers Dashboard')?></a>
                    </div>
                <? } ?>
            </div>

            <? if (($twoFactorRequired && $token) || !$twoFactorRequired) { ?>
                <p class="js-removeTimeout"><a href="https://wiki.unraid.net/Manual/Troubleshooting#Lost_root_Password" target="_blank"><?=_('Password recovery')?></a></p>
            <? } ?>

        </div>
    </section>
    <? if ($token) { ?>
        <script type="text/javascript">
            const $elsToRemove = document.querySelectorAll('.js-removeTimeout');
            const $elsToShow = document.querySelectorAll('.js-addTimeout');
            /**
             * A user can manually refresh the page or submit with the wrong username/password
             * the t2fa token will be re-used on these page refreshes. We need to keep track of the timeout across potential page
             * loads rather than setting the timer with a fresh timeout each page load
             */
            const tokenName = '<?=$token?>'.slice(-20);
            const ts = Date.now();
            const timeoutStarted = sessionStorage.getItem(tokenName) ? Number(sessionStorage.getItem(tokenName)) : ts;
            const timeoutDiff = ts - timeoutStarted; // current timestamp minus timestamp when token first set
            const timeoutMS = 297000 - timeoutDiff; // 5 minutes minus 3seconds or (5*60)*1000ms - 3000ms = 297000
            sessionStorage.setItem(tokenName, timeoutStarted);
            const tokenTimeout = setTimeout(() => {
                $elsToRemove.forEach(z => z.remove()); // remove elements
                $elsToShow.forEach(z => z.classList.remove('hidden')); // add elements
            }, timeoutMS); // if timeoutMS is negative value the timeout will trigger immediately
        </script>
    <? } ?>
</body>
</html>
