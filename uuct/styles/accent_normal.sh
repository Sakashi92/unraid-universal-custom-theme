######################################################################################################################
##                                                                                                                   #
##  ######## ##   ## ####### ###    ### #######      ######  ######  ##       ######  ######  ## ###    ##  ######   #
##     ##    ##   ## ##      ####  #### ##          ##      ##    ## ##      ##    ## ##   ## ## ####   ## ##        #
##     ##    ####### #####   ## #### ## #####       ##      ##    ## ##      ##    ## ######  ## ## ##  ## ##   ###  #
##     ##    ##   ## ##      ##  ##  ## ##          ##      ##    ## ##      ##    ## ##   ## ## ##  ## ## ##    ##  #
##     ##    ##   ## ####### ##      ## #######      ######  ######  #######  ######  ##   ## ## ##   ####  ######   #
##                                                                                                                   #
##                                  #######  ###### ######  ## ######  ########                                      #
##                                  ##      ##      ##   ## ## ##   ##    ##                                         #
##                                  ####### ##      ######  ## ######     ##                                         #
##                                       ## ##      ##   ## ## ##         ##                                         #
##                                  #######  ###### ##   ## ## ##         ##                                         #
##                                                                                                          v5       #
##                                       Created by: almulder                                                        #
##                                                                                                                   #
##      This script will replace the default unraid theme colors (orange) to the colors of your choice. This is      #
## meant to change as many areas as possible. There are only a few colors you need to select, inorder to change      #
## almost all the colors across screens including: Login Screen, Logo, Wait (Animated), Buttons, ect..               #
##                                                                                                                   #
## "/tmp/Original_Theme_Files" and "/boot/config/plugins/Original_Theme_Files" folders are where original themes     #
## files are backedup and stored. -- Do not delete the files (They are needed) --                                    #
##                                                                                                                   #
## Note: Only a few plugins are themed: user.scripts, Unraid-Nvidia, community.applications (More upon request!)     #
##                                                                                                                   #
######################################################################################################################
##                                           Disclamer / Waiver of Liability                                         #
##                                                                                                                   #
##       By using this plugin you agree I am in no way responsable for any damages that could occur from its use.    #
## You are free to redistribute and modify as needed as long as I am given original credit for the plugin.           #
##                                                                                                                   #
######################################################################################################################
#
#            ##############################################################
#            #         _  _ ____ ____ ____    _ _  _ ___  _  _ ___        #
#            #         |  | [__  |___ |__/    | |\ | |__] |  |  |         #
#            #         |__| ___] |___ |  \    | | \| |    |__|  |         #
#            #                                                            # 
#            #     Note: This only works for the Black Theme for now.     #
#            ##############################################################
#            #                                                            #
#            #    If needed you can use the color picker from here:       #
#            #    https://www.w3schools.com/colors/colors_picker.asp      #
#            #                                                            #   
#            ##############################################################
#
##########################################
## Restore to original Colors? ("Y","N") #
##########################################
Restore_Colors="n"
Black_Login="n"
Custom_Icon="n"
####################################################################
## Select a Dark color in hex format (Example-Dark Blue: "00378F") #
####################################################################
#Dark_Color="00378F"
Dark_Color="00378F"

######################################################################
## Select a Light color in hex format (Example-Light Blue: "42ADFA") #
######################################################################
#Light_Color="42ADFA"
Light_Color="42ADFA"

##################################################################
## Select a Med color in hex format (Example-Mid Blue: "317FB7") #
## Main background login Page 									 #
##################################################################
#Background_login="ffffff"
##################################################################
## Select a Med color in hex format (Example-Mid Blue: "317FB7") #
# box 1 = first accent | box 2 second accent					 #
# Background login Formular										 #
##################################################################
#Background_login_box1="000000"
#Background_login_box2="000000"

##################################################################
##               End of User Input                               #   
##################################################################
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
########################################################################
## Script Starts Here - Do not Modify unless you know what your doing. #   
########################################################################
echo " "
echo " "
echo " "
echo " "
echo "Theme Coloring Script - v5"
#echo " "
#echo " "



################################
## Check User Input for Errors #   
################################
######################################################################
errors="No"
if [ $Restore_Colors != 'N' ] && [ $Restore_Colors != 'Y' ] && [ $Restore_Colors != 'n' ] && [ $Restore_Colors != 'y' ]; then
	echo "Restore_Colors - Invalid Responce"
	echo " "
	error="Yes"
fi
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
if [ "$error" = "Yes" ]; then
	echo "User input missing/invalid! Please edit script with required info."
	echo " "
	echo " "
	exit 1
fi
######################################################################
#####################################################################

##################################
## Backup/Restore Original Files #   
##################################
######################################################################
backup_files_location=/tmp/Original_Theme_Files
if [ -d "$backup_files_location" ]; then
	echo
else 
	mkdir /tmp/Original_Theme_Files
fi
######################################################################
backup_files_location_webGui=/tmp/Original_Theme_Files/webGui
if [ -d "$backup_files_location_webGui" ]; then
	echo
else 
	mkdir /tmp/Original_Theme_Files/webGui
fi
######################################################################
#backup_files_location2=/boot/config/plugins/Original_Theme_Files
#if [ -d "$backup_files_location2" ]; then
#	echo 
#else 
#	mkdir /boot/config/plugins/Original_Theme_Files
#fi

backup_files_location2=/tmp/Original_Theme_Files/CA
if [ -d "$backup_files_location2" ]; then
	echo 
else 
	mkdir /tmp/Original_Theme_Files/CA
fi







######################################################################
File=UN-logotype-gradient.svg
Original_File_Loc=/usr/local/emhttp/webGui/images
if test -f "$backup_files_location_webGui/$File"; then
	cp $backup_files_location_webGui/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location_webGui/$File
fi
######################################################################
File=animated-logo.svg
Original_File_Loc=/usr/local/emhttp/webGui/images
if test -f "$backup_files_location_webGui/$File"; then
	cp $backup_files_location_webGui/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location_webGui/$File
fi
######################################################################
File=logging.htm
Original_File_Loc=/usr/local/emhttp
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=.login.php
Original_File_Loc=/usr/local/emhttp/webGui/include/
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=default-popup.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=jquery.sweetalert.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=jquery.ui.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles/
if test -f "$backup_files_location_webGui/$File"; then
	cp $backup_files_location_webGui/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location_webGui/$File
fi
######################################################################
File=log.htm
Original_File_Loc=/usr/local/emhttp/plugins/dynamix.docker.manager
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
#
######################
## Azure Theme Files #   
######################
######################################################################
File=default-azure.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=dynamix-azure.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=style-azure.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix.docker.manager/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
#
######################
## Black Theme Files #   
######################
######################################################################
File=default-black.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=dynamix-black.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=style-black.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix.docker.manager/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=dynamix-black.css
Original_File_Loc=/usr/local/emhttp/webGui/styles/
if test -f "$backup_files_location_webGui/$File"; then
	cp $backup_files_location_webGui/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location_webGui/$File
fi
######################################################################
#
#####################
## Gray Theme Files #   
#####################
######################################################################
File=default-gray.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=dynamix-gray.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=style-gray.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix.docker.manager/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
#
######################
## White Theme Files #   
######################
######################################################################
File=default-white.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=dynamix-white.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=style-white.css
Original_File_Loc=/usr/local/emhttp/plugins/dynamix.docker.manager/styles
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File
else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
File=power.png
Original_File_Loc=/usr/local/emhttp/plugins/dynamix.system.buttons/icons/
if test -f "$backup_files_location/$File"; then
	cp $backup_files_location/$File $Original_File_Loc/$File

else 
	cp $Original_File_Loc/$File $backup_files_location/$File
fi
######################################################################
#
######################
## Supported Plugins #   
######################
######################################################################
File=Userscripts.page
plgFile=user.scripts.plg
Original_File_Loc=/usr/local/emhttp/plugins/user.scripts/
plgOriginal_File_Loc=/boot/config/plugins/
if test -f "$backup_files_location2/$File"; then
	originalversion=`grep -m 1 '###' /boot/config/plugins/user.scripts.plg`	
	if [ "$originalversion" = "$backupversion" ]; then
		cp $backup_files_location2/$File $Original_File_Loc/$File
	else
		cp $Original_File_Loc/$File $backup_files_location2/$File
		cp $plgOriginal_File_Loc/$plgFile $backup_files_location2/$plgFile
	fi		
else 
	cp $Original_File_Loc/$File $backup_files_location2/$File
	cp $plgOriginal_File_Loc/$plgFile $backup_files_location2/$plgFile
fi


#############################
## Restore Original Colors? #   
#############################
if [ $Custom_Icon = 'Y' ] || [ $Custom_Icon = 'y' ]; then
	echo "custom icons copied"
	cp /boot/extra/uuct/icons/power.png /usr/local/emhttp/plugins/dynamix.system.buttons/icons/power.png
else 
	echo "original icons copied"
	cp /tmp/Original_Theme_Files/power.png /usr/local/emhttp/plugins/dynamix.system.buttons/icons/power.png
fi
######################################################################
if [ $Restore_Colors = 'Y' ] || [ $Restore_Colors = 'y' ]; then
	echo "Original Colors Restored"
	cp /tmp/Original_Theme_Files/power.png /usr/local/emhttp/plugins/dynamix.system.buttons/icons/power.png
	#echo ""
	exit 1
fi
######################################################################
######################################################################

####################
## Applying Colors #   
####################
######################################################################
echo "Applying Colors"

###################################
## Defineing Variables For Colors #   
###################################
old_dark_color="#E32929"
old_dark_color_a="#E22828"
old_dark_color_b="#E03237"


old_pass_highlight="#F15A2C"
old_nvida_highlight="color:red"
old_comm_app_highlight="#E68A00"

old_light_color="#FF8D30"
old_light_color_a="#FF8C2F"
old_light_color_b="#FD8C3C"
old_light_color_c="#F8BB86"
old_light_color_d="#F8D486"

new_dark_color="#$Dark_Color"
new_light_color="#$Light_Color"
new_pass_highlight="#FFFFFF"
new_nvida_highlight="color:#$Light_Color"
new_comm_app_highlight="#$Light_Color"
######################################################################


#######################
## Popup Info Section #   
#######################
oldtext="body{font-size:1.2rem;color:#1c1c1c;background:#f2f2f2;padding:0;margin:0;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}"
newtext="body{font-size:1.2rem;color:#E8E8E8;background:#1C1B1B;padding:0;margin:0;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/logging.htm
##################################################################################################################################################
oldtext="#sb-body-inner{position:absolute;height:100%;width:100%;color:#1c1b1b;background:#f2f2f2}"
newtext="#sb-body-inner{position:absolute;height:100%;width:100%;color:#E8E8E8;background:#$new_dark_color}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/webGui/styles/dynamix-black.css
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
##################################################################################################################################################
oldtext="#sb-body,#sb-loading{color:#1c1b1b;background-color:#f2f2f2}"
newtext="#sb-body,#sb-loading{color:#E8E8E8;background-color:#1C1B1B}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/webGui/styles/dynamix-black.css
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
##################################################################################################################################################
oldtext="#sb-body-inner{position:absolute;height:100%;width:100%;color:#1c1b1b;background:#f2f2f2}"
newtext="#sb-body-inner{position:absolute;height:100%;width:100%;color:#E8E8E8;background:#1C1B1B}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/webGui/styles/dynamix-black.css
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
##################################################################################################################################################
oldtext="#sb-wrapper{position:absolute;visibility:hidden;width:100px;border:1px #808080 solid;border-radius:10px;color:#1c1b1b;background:#f2f2f2}"
newtext="#sb-wrapper{position:absolute;visibility:hidden;width:100px;border:1px #808080 solid;border-radius:10px;color:#E8E8E8;background:#1C1B1B}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/webGui/styles/dynamix-black.css
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
##################################################################################################################################################
oldtext="#sb-info-inner,#sb-loading-inner,div.sb-message{color:#1c1b1b;background-color:#f2f2f2}"
newtext="#sb-info-inner,#sb-loading-inner,div.sb-message{color:#E8E8E8;background-color:#1C1B1B}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/webGui/styles/dynamix-black.css
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
##################################################################################################################################################
oldtext="#sb-title,#sb-title-inner{border-top-left-radius:10px;border-top-right-radius:10px;width:100%;height:5rem;line-height:5rem;font-family:clear-sans;font-size:1.8rem;font-weight:bold;letter-spacing:1.8px;background:#c0c0c0;color:#606060;text-indent:10px;text-align:center}"
newtext="#sb-title,#sb-title-inner{border-top-left-radius:10px;border-top-right-radius:10px;width:100%;height:5rem;line-height:5rem;font-family:clear-sans;font-size:1.8rem;font-weight:bold;letter-spacing:1.8px;background:-webkit-gradient(linear,left top,left bottom,from($new_dark_color),to());background:linear-gradient(180deg,$new_dark_color 0,$new_light_color);color:#e8e8e8;text-indent:10px;text-align:center}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/webGui/styles/dynamix-black.css
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
##################################################################################################################################################

##################################################################################################################################################
oldtext='ui-widget-header{border:1px solid #aaa;background:#ccc url(\"..\/images\/ui-bg_highlight-soft_75_cccccc_1x100.png\") 50% 50% repeat-x;color:#222;'
newtext='ui-widget-header{border:0px solid #aaa;background:-webkit-gradient(linear,left top,left bottom,from(#00378F),to(#42ADFA));background:linear-gradient(180deg,#00378F 0,#42ADFA);color: #e8e8e8;'
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.ui.css
##################################################################################################################################################
oldtext=".ui-dialog .ui-dialog-content{position:relative;border:0;padding:.5em 1em;background:none"
newtext=".ui-dialog .ui-dialog-content{position:relative;border:0;padding:.5em 1em;background:#1c1b1b;"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.ui.css
##################################################################################################################################################
oldtext='ui-widget-content{border:1px solid #aaa;background:#fff url(\"..\/images\/ui-bg_flat_75_ffffff_40x100.png\") 50% 50% repeat-x;color:#222}.ui-widget-content a{color:#222}'
newtext='ui-widget-content{border:1px solid #aaa;background:#1c1b1b; color:#222}.ui-widget-content a{color:#222}'
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.ui.css
##################################################################################################################################################
oldtext="border-bottom-right-radius:4px"
newtext="border-bottom-right-radius:0px"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.ui.css
##################################################################################################################################################
oldtext="border-bottom-left-radius:4px"
newtext="border-bottom-left-radius:0px"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.ui.css
##################################################################################################################################################
oldtext="border-top-right-radius:4px"
newtext="border-top-right-radius:10px"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.ui.css
##################################################################################################################################################
oldtext="border-top-left-radius:4px"
newtext="border-top-left-radius:10px"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.ui.css
##################################################################################################################################################
oldtext="body{font-size:1.3rem;padding:0;margin:0;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}"
newtext="body{font-size:1.3rem;padding:0;margin:0;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;color:#f2f2f2;background-color:#000000}"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix.docker.manager/log.htm

##################################################################################################################################################
oldtext="body{font-size:1.3rem;color:#1c1b1b;background:#f2f2f2;"
newtext="body{font-size:1.3rem;color:#f2f2f2;background:#1c1b1b;"
sed -i "s/$oldtext/$newtext/gI" /usr/local/emhttp/plugins/dynamix/styles/default-popup.css
##################################################################################################################################################
##############################################
## Replacing Original Colors with New Colors #   
##############################################
sed -i "s/$old_dark_color/$new_dark_color/gI" /usr/local/emhttp/webGui/images/UN-logotype-gradient.svg
sed -i "s/$old_light_color/$new_light_color/gI" /usr/local/emhttp/webGui/images/UN-logotype-gradient.svg
sed -i "s/$old_dark_color/$new_dark_color/gI" /usr/local/emhttp/webGui/images/animated-logo.svg
sed -i "s/$old_light_color/$new_light_color/gI" /usr/local/emhttp/webGui/images/animated-logo.svg
sed -i "s/$old_light_color/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix.system.buttons/icons/power.png
##################################################################################################################################################
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/logging.htm
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/logging.htm
##################################################################################################################################################
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/plugins/dynamix.docker.manager/styles/style-black.css
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix.docker.manager/styles/style-black.css
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/plugins/dynamix.docker.manager/log.htm
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix.docker.manager/log.htm
sed -i "s/#f15a2c/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix.docker.manager/log.htm
##################################################################################################################################################
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix/styles/dynamix-black.css
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/plugins/dynamix/styles/default-black.css
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix/styles/default-black.css
sed -i "s/$old_pass_highlight/$new_pass_highlight/gI" /usr/local/emhttp/plugins/dynamix/styles/default-black.css
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix/styles/default-black.css
##################################################################################################################################################
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.sweetalert.css
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.sweetalert.css
sed -i "s/$old_light_color_c/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.sweetalert.css
sed -i "s/$old_light_color_d/$new_dark_color/gI" /usr/local/emhttp/plugins/dynamix/styles/jquery.sweetalert.css
##################################################################################################################################################
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/plugins/dynamix/styles/default-popup.css
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/plugins/dynamix/styles/default-popup.css
##################################################################################################################################################
######################################################################
if [ $Black_Login = 'Y' ] || [ $Black_Login = 'y' ]; then
	echo "login blacked"
	cp /boot/extra/uuct/login/black.login.php /usr/local/emhttp/webGui/include/.login.php
else 
	echo "login unblacked"
	cp /boot/extra/uuct/login/original.login.php /usr/local/emhttp/webGui/include/.login.php
fi
sed -i "s/$old_dark_color_a/$new_dark_color/gI" /usr/local/emhttp/webGui/include/.login.php
sed -i "s/$old_light_color_a/$new_light_color/gI" /usr/local/emhttp/webGui/include/.login.php
sed -i "s/$old_dark_color_b/$new_dark_color/gI" /usr/local/emhttp/webGui/include/.login.php
sed -i "s/$old_light_color_b/$new_light_color/gI" /usr/local/emhttp/webGui/include/.login.php
sed -i "s/$old_pass_highlight/$new_pass_highlight/gI" /usr/local/emhttp/webGui/include/.login.php
#################################################################################################################################################

#############################
#############################
## Restore Original Colors? #   
#############################
echo " "
echo " "
echo "Done Applying Colors"
echo " "
echo " "
echo "Script End"
echo " "
echo " "
#############################
exit 1


##################
## End Of Script #   
##################