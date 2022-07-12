#!/bin/bash
##########################################################################################################
##                                                                                                      ##
##       ##    ##   ##    ##   ######  ########       #######  ###### ######  ## ######  ########       ##
##       ##    ##   ##    ##  ##          ##	      ##      ##      ##   ## ## ##   ##    ##          ##
##       ##    ##   ##    ##  ##          ##          ####### ##      ######  ## ######     ##          ##
##       ##    ##   ##    ##  ##          ##	           ## ##      ##   ## ## ##         ##          ##
##       ########   ########   ######     ##	      #######  ###### ##   ## ## ##         ##          ##
##                                                                                                      ##
##                               unRAID Universal Custom Theme v0.7.6                                   ##
##                                       Created by: Sakashi                                            ##
##                                                                                                      ##
##########################################################################################################
##                                Benutzereingabe Start  / Custom Settings Start                        ##
##########################################################################################################
##########################################################################################################
##Custom_Icon = passend zum schwarzen background | Custom_Icon = Custom icons for the black Background  ##
## n = nein / no    |    y = ja / yes                                                                   ##
##########################################################################################################
Custom_Icon='y'
##########################################################################################################
## Benutzerdefinierte Navigationsleiste  |  Custom Navigationbar                                        ##
## n = nein / no    |    y = ja / yes      |  c = mitte | center                                        ##
##########################################################################################################
navbar_swap='y'
##########################################################################################################
## Blauer Accent | 0062aa = Dunkelblau | 00ddfe = Hellblau                                              ##
## blue accent   | 0062aa = dark blue  | 00ddfe = light blue                                            ##
## Hex Farben ohne # benutzen!                                                                          ##
## hex color without #!                                                                                 ##
##########################################################################################################
Dark_Color='42ADFA'
Light_Color='0062aa'
Dark_Color_Title='42ADFA'    # Hintergrundfarbe der Abschnitte für Farbverlauf *1                       ##
Background='000000'          # Hintergrundfarbe | Background color             *2                       ##
Text='ffffff'                # Textfarbe der kompletten Schrift | textcolor for all the text *3         ##
Login_Box_Background='000000'
Login_Background='080808'
##########################################################################################################
## *1 = titlecolor for column in rainbow | *2 = background color for the page                           ##
## *3 = textcolor for complete text in unraid                                                           ##
##########################################################################################################
## RGB_Color muss in RGB angegeben werden  | rgb color go to rgb spectrum                               ##
## 0, 98, 170 ist blau | 0, 98, 170 is blue                                                             ##
## Navigationsleiste Farbe beim rüberfahren |      Navbar Highlight Color                               ##
##########################################################################################################
RGB_Color='0, 98, 170'
##########################################################################################################
## Hier kannst du alles rückgänig machen y = alles löschen | n = alles so lassen wie es ist             ##
## here can you delete the theme complete. y = for delete all files | n = nothing                       ##
##########################################################################################################
Restore_Colors='n'
##########################################################################################################
##########################################################################################################
##                                Benutzereingabe Ende  / Custom Settings End                           ##
##########################################################################################################
#
#
#
#
#
#
#############################################################################
## Script Starts Here - Do not Modify unless you know what your doing.      #
#############################################################################
#############################################################################
## Script startet ab hier - nicht verändern wenn du nicht weißt was du tust #   
#############################################################################
#############################################################################
##Deine Sprache de oder en | your language de or en
#############################################################################
language='en'
#############################################################################
installed_version='0.7.6'
first_start='n'
activate_theme='n'

if [ $Restore_Colors = 'Y' ] || [ $Restore_Colors = 'y' ]; then

if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "Das komplette Theme wird rückgängig gemacht."
	echo "Dabei werden auch alle heruntergeladene"
	echo "und erstellte Dateien gelöscht"
else
	echo "The complete theme is in reseting"
	echo "all Theme data will delete"
fi
	sed -i 's/Restore_Colors="n"/Restore_Colors="y"/gI' /boot/config/plugins/user.scripts/scripts/uuct/script
	sed -i "s/#$(cat /boot/extra/uuct/backup/color.cfg | head -n11 | tail -n1)/#ff8c2f/gI" /usr/local/emhttp/plugins/user.scripts/Userscripts.page
	sed -i "s/#$(cat /boot/extra/uuct/backup/color.cfg | head -n11 | tail -n1)/#ff8c2f/gI" /usr/local/emhttp/plugins/compose.manager/php/compose_manager_main.php
	sed -i "1s/#$Login_Box_Background/#2B2A29/gI" /usr/local/emhttp/webGui/include/.login.php
	sed -i "2s/#$Login_Background/#1C1B1B/gI" /usr/local/emhttp/webGui/include/.login.php
	sleep 1
	sh /boot/config/plugins/user.scripts/scripts/uuct/script
	rm -r /boot/config/plugins/theme.engine/themes/uuct-black.cfg
	rm -r /boot/config/plugins/theme.engine/theme.engine.cfg
	rm -r /boot/config/plugins/theme.engine/themes/uuct-black.css
	rm -r /boot/extra/uuct
	rm -r /boot/config/plugins/user.scripts/scripts/uuct
	rm -r /boot/config/plugins/user.scripts/scripts/uuct_helper
	
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "Alles wurde rückgängig gemacht."
else
	echo "Everything has been undone."
fi
exit 1

fi

if [ -d /boot/config/plugins/user.scripts/scripts/uuct_helper ]; then
	echo ""
else
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo 'Der Scriptname ist falsch, bitte das Script komplett neu anlegen mit dem Namen "uuct_helper"! ohne "" '
	echo "WICHTIG DAS SCRIPT KOMPLETT NEU ANLEGEN UNTER DEM RICHTIGEN NAMEN."
else
	echo 'The script name is wrong, please create the script from scratch with the name "uuct_helper"! without ""'
	echo "IMPORTANT CREATE THE SCRIPT COMPLETELY NEW UNDER THE CORRECT NAME."
fi
	exit 1
fi


if [ -d /boot/extra ]; then
	echo ""
else
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "Der Ordner /extra in /boot kann nicht gefunden werden. Wird erstellt..."
else
	echo "The /extra folder in /boot cannot be found. Creating..."
fi
	mkdir /boot/extra
fi

if [ -d /boot/extra/uuct ]; then
	echo
else
	mkdir /boot/extra/uuct
fi

if [ $first_start = 'Y' ] || [ $first_start = 'y' ]; then
sed -i "75s/first_start='y'/first_start='n'/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script

if [ -d /boot/extra/uuct/backup ]; then
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "Backup der Variablen gefunden. Wird wiederhergestellt"
else
	echo "Backup of variables found. Will be restored"
fi
	sed -i "21s/Black_Login='n'/$(cat /boot/extra/uuct/backup/color.cfg | head -n1 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "22s/Custom_Icon='n'/$(cat /boot/extra/uuct/backup/color.cfg | head -n2 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "27s/navbar_swap='n'/$(cat /boot/extra/uuct/backup/color.cfg | head -n3 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "34s/Dark_Color='0062aa'/$(cat /boot/extra/uuct/backup/color.cfg | head -n4 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "35s/Light_Color='0062aa'/$(cat /boot/extra/uuct/backup/color.cfg | head -n5 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "36s/Dark_Color_Title='000000'/$(cat /boot/extra/uuct/backup/color.cfg | head -n6 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "37s/Background='000000'/$(cat /boot/extra/uuct/backup/color.cfg | head -n7 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "38s/Text='ffffff'/$(cat /boot/extra/uuct/backup/color.cfg | head -n8 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "47s/RGB_Color='0, 98, 170'/$(cat /boot/extra/uuct/backup/color.cfg | head -n9 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "37s/Login_Box_Background='1C1B1B'/$(cat /boot/extra/uuct/backup/login.cfg | head -n1 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sed -i "38s/Login_Background='2B2A29'/$(cat /boot/extra/uuct/backup/login.cfg | head -n2 | tail -n1)/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	sleep 3
else
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "Es ist kein Backup vorhanden. Backup wird erstellt."
else
	echo "There is no backup. Backup is created."
fi
	mkdir /boot/extra/uuct/backup
	touch /boot/extra/uuct/backup/color.cfg
	echo "Black_Login='$Black_Login'" > /boot/extra/uuct/backup/color.cfg
	echo "Custom_Icon='$Custom_Icon'" >> /boot/extra/uuct/backup/color.cfg
	echo "navbar_swap='$navbar_swap'" >> /boot/extra/uuct/backup/color.cfg
	echo "Dark_Color='$Dark_Color'" >> /boot/extra/uuct/backup/color.cfg
	echo "Light_Color='$Light_Color'" >> /boot/extra/uuct/backup/color.cfg
	echo "Dark_Color_Title='$Dark_Color_Title'" >> /boot/extra/uuct/backup/color.cfg
	echo "Background='$Background'" >> /boot/extra/uuct/backup/color.cfg
	echo "Text='$Text'" >> /boot/extra/uuct/backup/color.cfg
	echo "RGB_Color='$RGB_Color'" >> /boot/extra/uuct/backup/color.cfg
	echo "$installed_version" >> /boot/extra/uuct/backup/color.cfg
	echo "ff8c2f" >> /boot/extra/uuct/backup/color.cfg
	echo "$Login_Box_Background" > /boot/extra/uuct/backup/login.cfg
	echo "$Login_Background" >> /boot/extra/uuct/backup/login.cfg
fi

if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "######################################################################"
	echo "Willkommen im unRAID Universal Custom Theme installer / Updater."
	echo "Der installer / updater startet, es werden einige Daten von github heruntergeladen."
	echo "Github: https://github.com/Sakashi92/unraid-universal-custom-theme/"
	echo "Die Daten werden in /boot/extra/uuct abgelegt und sind für das Theme notwendig."
else
	echo "######################################################################"
	echo "Welcome to the unRAID Universal Custom Theme installer / updater."
	echo "The installer / updater is starting, some data will be downloaded from github."
	echo "Github: https://github.com/Sakashi92/unraid-universal-custom-theme/"
	echo "The data is stored in /boot/extra/uuct and is necessary for the theme."
fi
    echo "######################################################################"
	echo "######################################################################"
	echo "######################################################################"
	sleep 10
	cd /tmp
	wget https://github.com/Sakashi92/unraid-universal-custom-theme/archive/refs/heads/dev.zip
	unzip dev.zip
	cp -r /tmp/unraid-universal-custom-theme-dev/uuct /boot/extra/
	rm -r dev.zip
	rm -r unraid-universal-custom-theme-dev
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "Es wird nach ein vorhandenes Backup geschaut."
else
	echo "An existing backup is checked."
fi

if [ -d /boot/config/plugins/user.scripts/scripts/uuct ]; then
	echo ""
else
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "Der Ordner /boot/config/plugins/user.scripts/scripts/uuct kann nicht gefunden werden. Wird erstellt..."
else
	echo "the folder /boot/config/plugins/user.scripts/scripts/uuct cannot found. is created..."
fi
	mkdir /boot/config/plugins/user.scripts/scripts/uuct
	touch /boot/config/plugins/user.scripts/scripts/uuct/name
	touch /boot/config/plugins/user.scripts/scripts/uuct/script
	echo "uuct" > /boot/config/plugins/user.scripts/scripts/uuct/name
	cat /boot/extra/uuct/styles/accent_normal.sh > /boot/config/plugins/user.scripts/scripts/uuct/script
	cp /boot/extra/uuct/styles/uuct.css /boot/config/plugins/theme.engine/themes/uuct-black.css
	cp /boot/extra/uuct/styles/uuct.cfg /boot/config/plugins/theme.engine/themes/uuct-black.cfg
fi
	echo "######################################################################"
	echo "######################################################################"
	echo "######################################################################"
	echo "######################################################################"
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo " Vorbereitungen abgeschlossen."
	echo " Einfach das Script bearbeiten mit deinen Farbwerten und dann erneut ausführen."
	echo " Die Farben werden in hex ohne # angegeben. Die Ausnahme machen die Akzente in der Navbar."
	echo " Die Farben in der Navbar werden in RGB angegeben. Einfach mit dem verlinkten Tool"
	echo " die Farben umwandeln: https://www.farb-tabelle.de/de/farbtabelle.htm "
        echo ' Bitte warten bis der "Fertig" Button erscheint.'
else
	echo " preparations complete."
	echo " Just edit the script with your color values ​​and then run it again."
	echo " The colors are given in hex without #. The exception are the accents in the navbar."
	echo " The colors in the navbar are specified in RGB. Simply with the linked tool"
	echo " convert the colors: https://www.farb-tabelle.de/de/farbtabelle.htm "
        echo ' Please wait with the "Finish" Button is visible.'
fi

sleep 10
sh /boot/config/plugins/user.scripts/scripts/uuct_helper/script

else 

if ! [[ $Dark_Color =~ ^[0-9A-Fa-f]{6}$ ]] ; then

	echo "Dark Color - Invalid Hex Code"
	echo " "
	error="Yes"
fi
if ! [[ $Light_Color =~ ^[0-9A-Fa-f]{6}$ ]] ; then
	echo "Light_Color - Invalid Hex Code"
	echo " "
	error="Yes"
fi
if ! [[ $Background =~ ^[0-9A-Fa-f]{6}$ ]] ; then
	echo "Background - Invalid Hex Code"
	echo " "
	error="Yes"
fi

if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "CSS und sh script mit den Farben wird erstellt."
else
	echo "CSS and sh script with the colors is created."
fi
	if [ $navbar_swap = 'N' ] || [ $navbar_swap = 'n' ]; then
	cat /boot/extra/uuct/styles/uuct.css > /boot/config/plugins/theme.engine/themes/uuct-black.css
	cp /boot/extra/uuct/styles/uuct.cfg /boot/config/plugins/theme.engine/themes/uuct-black.cfg
	fi
	
	if [ $navbar_swap = 'Y' ] || [ $navbar_swap = 'y' ]; then
	cat /boot/extra/uuct/styles/uuct.css > /boot/config/plugins/theme.engine/themes/uuct-black.css
	cat /boot/extra/uuct/styles/navbar_mod.css >> /boot/config/plugins/theme.engine/themes/uuct-black.css
	cp /boot/extra/uuct/styles/uuct.cfg /boot/config/plugins/theme.engine/themes/uuct-black.cfg
	fi
	
    if [ $navbar_swap = 'C' ] || [ $navbar_swap = 'c' ]; then
	cat /boot/extra/uuct/styles/uuct.css > /boot/config/plugins/theme.engine/themes/uuct-black.css
	cat /boot/extra/uuct/styles/navbar_center_mod.css >> /boot/config/plugins/theme.engine/themes/uuct-black.css
	cp /boot/extra/uuct/styles/uuct.cfg /boot/config/plugins/theme.engine/themes/uuct-black.cfg
fi
 	
if [ $Custom_Icon = 'Y' ] || [ $Custom_Icon = 'y' ]; then
	sed -i 's/Custom_Icon="n"/Custom_Icon="y"/gI' /boot/extra/uuct/styles/accent_normal.sh
	else
	sed -i 's/Custom_Icon="y"/Custom_Icon="n"/gI' /boot/extra/uuct/styles/accent_normal.sh
fi

if [ -d /boot/config/plugins/user.scripts/scripts/uuct ]; then
	echo ""
else
	mkdir /boot/config/plugins/user.scripts/scripts/uuct
	touch /boot/config/plugins/user.scripts/scripts/uuct/name
	touch /boot/config/plugins/user.scripts/scripts/uuct/script
	echo "uuct" > /boot/config/plugins/user.scripts/scripts/uuct/name
	cat /boot/extra/uuct/styles/accent_normal.sh > /boot/config/plugins/user.scripts/scripts/uuct/script
fi

if [ $activate_theme = 'Y' ] || [ $activate_theme = 'y' ]; then
	cp /boot/extra/uuct/styles/uuct.cfg /boot/config/plugins/theme.engine/theme.engine.cfg
	sed -i "76s/activate_theme='y'/activate_theme='n'/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	else
	echo ""
fi

cat /boot/extra/uuct/styles/accent_normal.sh > /boot/config/plugins/user.scripts/scripts/uuct/script
sed -i "s/42ADFA/$Light_Color/gI" /boot/config/plugins/user.scripts/scripts/uuct/script
sed -i "s/00378F/$Dark_Color/gI" /boot/config/plugins/user.scripts/scripts/uuct/script
sed -i "s/0062aa/$Light_Color/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/030303/$Dark_Color_Title/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/000000/$Background/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/0062ab/$Dark_Color/gI" /boot/config/plugins/user.scripts/scripts/uuct/script
sed -i "s/ffffff/$Text/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/00ddfe/$Dark_Color/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/0, 98, 170/$RGB_Color/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css

sh /boot/config/plugins/user.scripts/scripts/uuct/script

new_light_color="#$Light_Color"
old_light_color="#$(cat /boot/extra/uuct/backup/color.cfg | head -n11 | tail -n1)"
sed -i "s/#ff8c2f/$new_light_color/gI" /usr/local/emhttp/plugins/user.scripts/Userscripts.page
sed -i "s/#ff8c2f/$new_light_color/gI" /usr/local/emhttp/plugins/compose.manager/php/compose_manager_main.php
sed -i "s/$old_light_color/$new_light_color/gI" /usr/local/emhttp/plugins/user.scripts/Userscripts.page
sed -i "s/$old_light_color/$new_light_color/gI" /usr/local/emhttp/plugins/compose.manager/php/compose_manager_main.php

Login_Box_Background_old="#$(cat /boot/extra/uuct/backup/login.cfg | head -n1 | tail -n1)"
Login_Box_Background_new="#$Login_Box_Background"
Login_Background_old="#$(cat /boot/extra/uuct/backup/login.cfg | head -n2 | tail -n1)"
Login_Background_new="#$Login_Background"

sed -i "362s/#2B2A29/$Login_Box_Background_new/gI" /usr/local/emhttp/webGui/include/.login.php
sed -i "362s/$Login_Box_Background_old/$Login_Box_Background_new/gI" /usr/local/emhttp/webGui/include/.login.php

sed -i "454s/#2B2A29/$Login_Box_Background_new/gI" /usr/local/emhttp/webGui/include/.login.php
sed -i "454s/$Login_Box_Background_old/$Login_Box_Background_new/gI" /usr/local/emhttp/webGui/include/.login.php

sed -i "277s/#1C1B1B/$Login_Background_new/gI" /usr/local/emhttp/webGui/include/.login.php
sed -i "277s/$Login_Background_old/$Login_Background_new/gI" /usr/local/emhttp/webGui/include/.login.php


if [ -d /boot/extra/uuct/backup ]; then
	echo "Black_Login='$Black_Login'" > /boot/extra/uuct/backup/color.cfg
	echo "Custom_Icon='$Custom_Icon'" >> /boot/extra/uuct/backup/color.cfg
	echo "navbar_swap='$navbar_swap'" >> /boot/extra/uuct/backup/color.cfg
	echo "Dark_Color='$Dark_Color'" >> /boot/extra/uuct/backup/color.cfg
	echo "Light_Color='$Light_Color'" >> /boot/extra/uuct/backup/color.cfg
	echo "Dark_Color_Title='$Dark_Color_Title'" >> /boot/extra/uuct/backup/color.cfg
	echo "Background='$Background'" >> /boot/extra/uuct/backup/color.cfg
	echo "Text='$Text'" >> /boot/extra/uuct/backup/color.cfg
	echo "RGB_Color='$RGB_Color'" >> /boot/extra/uuct/backup/color.cfg
	echo "$installed_version" >> /boot/extra/uuct/backup/color.cfg
	echo "$Light_Color" >> /boot/extra/uuct/backup/color.cfg
	echo "$Login_Box_Background" > /boot/extra/uuct/backup/login.cfg
	echo "$Login_Background" >> /boot/extra/uuct/backup/login.cfg
else
	echo ""
fi

echo "############################################################################################################"
if [ $language = 'de' ] || [ $language = 'de' ]; then
	echo "#   Zuletzt nur noch das Script uuct_helper automatisch mit dem Array starten lassen.                      "
	echo "#   Das uuct script muss in User Scripts vorhanden sein und darf nicht gelöscht werden!                    "
	echo "#   Farben kannst du mit dem Script hier bequem einstellen.                                                "
	echo "#   Unter Einstellungen -> Anzeigeeinstellungen  kannst du noch Farben für den Header bereich einstellen   "
	echo "#   Unter Einstellungen -> Theme Engine kannst du auch die Green Orbs anpassen in der Farbe die du willst. "
	echo "#   Die Farben werden in hex ohne # angegeben. Die Ausnahme machen die Akzente in der Navbar."
	echo "#   Die Farben in der Navbar werden in RGB angegeben. Einfach mit dem verlinkten Tool"
	echo "#   die Farben umwandeln: https://www.farb-tabelle.de/de/farbtabelle.htm "
else
	echo "#   Finally, let the uuct_helper script start automatically with the array.                             "
	echo "#   uuct script dont delete from user script this script must available!                    "
	echo "#   You can easily set colors with the script here.                                                "
	echo "#   Under Settings -> Display settings you can set colors for the header area   "
	echo "#   Under Settings -> Theme Engine you can also customize the Green Orbs to the color you want. "
	echo "#   The colors are given in hex without #. The exception are the accents in the navbar."
	echo "#   The colors in the navbar are specified in RGB. Simply with the linked tool"
	echo "#   convert the colors: https://www.farb-tabelle.de/de/farbtabelle.htm "
fi
echo "############################################################################################################"
fi