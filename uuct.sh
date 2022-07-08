#!/bin/bash
##########################################################################################################
##                                                                                                      ##
##       ##    ##   ##    ##   ######  ########       #######  ###### ######  ## ######  ########       ##
##       ##    ##   ##    ##  ##          ##	      ##      ##      ##   ## ## ##   ##    ##          ##
##       ##    ##   ##    ##  ##          ##          ####### ##      ######  ## ######     ##          ##
##       ##    ##   ##    ##  ##          ##	           ## ##      ##   ## ## ##         ##          ##
##       ########   ########   ######     ##	      #######  ###### ##   ## ## ##         ##          ##
##                                                                                                      ##
##                               unRAID Universal Custom Theme v0.4                                     ##
##                                       Created by: Sakashi                                            ##
##                                                                                                      ##
##########################################################################################################
##                                Benutzereingabe Start  / Custom Settings Start                        ##
##########################################################################################################
##########################################################################################################
## Black_Login = Schwarzer Hintergrund | Custom_Icon = zum schwarzen Hintergrund passende Icons         ##
## Black_Login = Black Background | Custom_Icon = Custom icons for the black Background                 ##
## n = nein / no    |    y = ja / yes                                                                   ##
##########################################################################################################
Black_Login="n"
Custom_Icon="n"
##########################################################################################################
## Benutzerdefinierte Navigationsleiste  |  Custom Navigationbar                                        ##
## n = nein / no    |    y = ja / yes      |  c = mitte | center                                        ##
##########################################################################################################
navbar_swap="c"
##########################################################################################################
## Blauer Accent | 0062aa = Dunkelblau | 00ddfe = Hellblau                                              ##
## blue accent   | 0062aa = dark blue  | 00ddfe = light blue                                            ##
## Hex Farben ohne # benutzen!                                                                          ##
## hex color without #!                                                                                 ##
##########################################################################################################
Dark_Color="0062aa"
Light_Color="0062aa"
Dark_Color_Title="000000"    # Hintergrundfarbe der Abschnitte für Farbverlauf *1
Background="000000"          # Hintergrundfarbe | Background color             *2                       ##
Text="ffffff"                # Textfarbe der kompletten Schrift | textcolor for all the text            ##
##########################################################################################################
## RGB_Color muss in RGB angegeben werden  | rgb color go to rgb spectrum                               ##
## 0, 98, 170 ist blau | 0, 98, 170 is blue                                                             ##
## Navigationsleiste Farbe beim rüberfahren |      Navbar Highlight Color                               ##
##########################################################################################################
RGB_Color="0, 98, 170"
##########################################################################################################
## Hier kannst du alles rückgänig machen y = alles löschen | n = alles so lassen wie es ist             ##
## here can you delete the theme complete. y = for delete all foles | n = nothing                       ##
##         WIP!! not fully workly, please reboot the server after run Restore_Colors                    ##
##    WIP!! nicht komplett funktionsfähig, nach ausführen von Restore_Colors Server neu starten         ##
##########################################################################################################
Restore_Colors="n"
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
first_start="y"

if [ $Restore_Colors = "Y" ] || [ $Restore_Colors = "y" ]; then

	echo "Das komplette Theme wird rückgängig gemacht."
	echo "Dabei werden auch alle heruntergeladene"
	echo "und erstellte Dateien gelöscht"
	sed -i 's/Restore_Colors="n"/Restore_Colors="y"/gI' /boot/config/plugins/user.scripts/scripts/uuct/script
	sleep 1
	sh /boot/config/plugins/user.scripts/scripts/uuct/script
	cp /boot/extra/uuct/ca/Userscripts.page /usr/local/emhttp/plugins/user.scripts/Userscripts.page
	rm -r /boot/config/plugins/theme.engine/themes/uuct-black.cfg
	rm -r /boot/config/plugins/theme.engine/themes/uuct-black.css
	rm -r /boot/extra/uuct
	rm -r /boot/config/plugins/user.scripts/scripts/uuct
	rm -r /boot/config/plugins/user.scripts/scripts/uuct_installer
	echo "Alles wurde rückgängig gemacht."
	echo "Gehe jetzt zur Theme Engine und stelle ein default Theme ein, z.b. Ashes-Black"
exit 1
fi

if [ -d /boot/config/plugins/user.scripts/scripts/uuct_installer ]; then
	sed -i '67,69s/first_start="y"/first_start="n"/gI' /boot/config/plugins/user.scripts/scripts/uuct_installer/script
else
	echo 'Der Scriptname ist falsch, bitte das Script komplett neu anlegen mit dem Namen "uuct_installer"! ohne "" '
	echo "WICHTIG DAS SCRIPT KOMPLETT NEU ANLEGEN UNTER DEM RICHTIGEN NAMEN."
	exit 1
fi


if [ -d /boot/extra ]; then
	echo ""
else
	echo "Der Ordner /extra in /boot kann nicht gefunden werden. Wird erstellt..."
	mkdir /boot/extra
fi


if [ $first_start = "Y" ] || [ $first_start = "y" ]; then

	echo "######################################################################"
	echo "Willkommen im unRAID Universal Custom Theme installer."
	echo "Da du den installer das erste mal startest werden einige Daten von github heruntergeladen."
	echo "Github: https://github.com/Sakashi92/unraid-universal-custom-theme/"
	echo "Die Daten werden in /boot/extra/uuct abgelegt und sind für das Theme notwendig."
    echo "######################################################################"
	echo "######################################################################"
	echo "######################################################################"
	sleep 3
	cd /tmp
	wget https://github.com/Sakashi92/unraid-universal-custom-theme/archive/refs/heads/dev.zip
	unzip dev.zip
	cp -r /tmp/unraid-universal-custom-theme-dev/uuct /boot/extra/
	rm -r dev.zip
	rm -r unraid-universal-custom-theme-dev
	echo "######################################################################"
	echo "######################################################################"
	echo "######################################################################"
	echo "Du kannst jetzt zu den Einstellungen -> Theme Engine unter Saved Themes das Theme Uuct-black laden"
	echo "Danach bearbeitest du das Script hier mit deinen Farbwerten und startest das Script neu."
    echo "Die Farben werden in hex angegeben jedoch ohne # "
    echo "######################################################################"
if [ -d /boot/config/plugins/user.scripts/scripts/uuct ]; then
	echo ""
else
	echo "Der Ordner /boot/config/plugins/user.scripts/scripts/uuct kann nicht gefunden werden. Wird erstellt..."
	mkdir /boot/config/plugins/user.scripts/scripts/uuct
	touch /boot/config/plugins/user.scripts/scripts/uuct/name
	touch /boot/config/plugins/user.scripts/scripts/uuct/script
	echo "uuct" > /boot/config/plugins/user.scripts/scripts/uuct/name
	cat /boot/extra/uuct/styles/accent_normal.sh > /boot/config/plugins/user.scripts/scripts/uuct/script
	cp /boot/extra/uuct/styles/uuct.css /boot/config/plugins/theme.engine/themes/uuct-black.css
	cp /boot/extra/uuct/styles/uuct.cfg /boot/config/plugins/theme.engine/themes/uuct-black.cfg
fi
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
	echo "CSS und sh script mit den Farben wird erstellt."
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

if [ $Black_Login = 'Y' ] || [ $Black_Login = 'y' ]; then
	sed -i 's/Black_Login="n"/Black_Login="y"/gI' /boot/extra/uuct/styles/accent_normal.sh
	else
	sed -i 's/Black_Login="y"/Black_Login="n"/gI' /boot/extra/uuct/styles/accent_normal.sh

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

sed -i "s/42ADFA/$Light_Color/gI" /boot/config/plugins/user.scripts/scripts/uuct/script
sed -i "s/00378F/$Dark_Color/gI" /boot/config/plugins/user.scripts/scripts/uuct/script
sed -i "s/0062aa/$Light_Color/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/030303/$Dark_Color_Title/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/000000/$Background/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/0062ab/$Dark_Color/gI" /boot/config/plugins/user.scripts/scripts/uuct/script
sed -i "s/ffffff/$Text/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/00ddfe/$Dark_Color/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css
sed -i "s/0, 98, 170/$RGB_Color/gI" /boot/config/plugins/theme.engine/themes/uuct-black.css

new_light_color="#$Light_Color"
cp /boot/extra/uuct/ca/Userscripts.page /usr/local/emhttp/plugins/user.scripts/Userscripts.page
sed -i "s/#ff8c2f/$new_light_color/gI" /usr/local/emhttp/plugins/user.scripts/Userscripts.page

sh /boot/config/plugins/user.scripts/scripts/uuct/script

echo "###############################################################################################"
echo "Zuletzt nur noch das Script uuct ausführen und es automatisch mit dem Array starten lassen.   #"
echo "Farben kannst du mit dem Script hier bequem einstellen.                                       #"
echo "###############################################################################################"


fi