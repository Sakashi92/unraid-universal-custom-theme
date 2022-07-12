#!/bin/sh
online_version=$(curl -s https://raw.githubusercontent.com/Sakashi92/unraid-universal-custom-theme/dev/cfg/version.cfg)
if [ -d /boot/extra/uuct/backup ]; then
	offline_version_de=$(cat /boot/extra/uuct/backup/color.cfg | head -n10 | tail -n1)
	offline_version_en=$(cat /boot/extra/uuct/backup/color.cfg | head -n10 | tail -n1)
else
	offline_version_de="Nicht Installiert"
	offline_version_en="not installed"
fi
echo -e "Willkommen beim installer und Updater vom unRAID Universal Custom Theme."
echo "Welche Sprache sprichst du? - Bitte auswählen und enter drücken."
echo "#############################################################################"
echo "Welcome to the installer and updater from unRAID Universal Custom Theme."
echo "What is your language? - Please choose and press enter."
menu=''
options=("Deutsch" "english" "beenden / exit")
select opt in "${options[@]}"
do
        case $opt in
                "Deutsch")
if [ "$offline_version_de" != "$online_version" ]
then
	echo -e "\nHier gibts ein Update"
	echo "###########################"
	echo "Lokal: $offline_version_de"
	echo -e "Online: $online_version\n"
    echo "#############################################################################################"
	echo "Bei einem Update gehen alle selbstgemachten Einstellungen nicht verloren,"
	echo "solange du mindestens version 0.5 installiert hast. Alles davor hat keine Backup funktion"
	echo "Sichere vorher deine hexwerte seperat um die Farben wiederherzustellen"
	echo "Du hast 15 sec Zeit das Script mit strg + c abzubrechen!"
	echo "#############################################################################################"
	sleep 10
	echo "5..."
	sleep 1
	echo "4..."
	sleep 1
	echo "3..."
	sleep 1
	echo "2..."
	sleep 1
	echo "1..."
	echo "#############################################################################################"
	echo "Daten werden nun heruntergeladen und vorhandene überschrieben"
	echo "#############################################################################################"
	sleep 1
	wget -P /boot/config/plugins/user.scripts/scripts/uuct_helper https://raw.githubusercontent.com/Sakashi92/unraid-universal-custom-theme/dev/uuct_helper.sh
	cat /boot/config/plugins/user.scripts/scripts/uuct_helper/uuct_helper.sh > /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	rm -r /boot/config/plugins/user.scripts/scripts/uuct_helper/uuct_helper.sh
	touch /boot/config/plugins/user.scripts/scripts/uuct_helper/name
	echo "uuct_helper" > /boot/config/plugins/user.scripts/scripts/uuct_helper/name
	echo "#############################################################################################"
	echo "Führe bitte jetzt das Script uuct_helper in den user.scripts über die Weboberfläche aus."
	echo "#############################################################################################" 
else
    echo  "Es gibt kein neues Update. "
	echo -e "\nInallierte Version: $offline_version"
	echo -e "Online Version: $online_version"
	sleep 3
exit 1
fi
						break
                        ;;
                "english")
				
if [ "$offline_version_en" != "$online_version" ]
then
    echo -e "\nHere is a Update"
	echo "###########################"
	echo "Local: $offline_version_en"
	echo -e "Online:$online_version\n"
	echo "#############################################################################################"
	echo "With an update, all self-made settings are not lost"
	echo "as long as you have at least version 0.5 installed. Everything before that has no backup function"
	echo "Save your hex values ​​separately beforehand to restore the colors"
	echo "You have 15 seconds to cancel the script with ctrl + c!"
	echo "#############################################################################################"
	sleep 10
	echo "5..."
	sleep 1
	echo "4..."
	sleep 1
	echo "3..."
	sleep 1
	echo "2..."
	sleep 1
	echo "1..."
	echo "#############################################################################################"
	echo "Data will now be downloaded and existing ones will be overwritten"
	echo "#############################################################################################"
	sleep 1
	wget -P /boot/config/plugins/user.scripts/scripts/uuct_helper https://raw.githubusercontent.com/Sakashi92/unraid-universal-custom-theme/dev/uuct_helper.sh
	cat /boot/config/plugins/user.scripts/scripts/uuct_helper/uuct_helper.sh > /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	rm -r /boot/config/plugins/user.scripts/scripts/uuct_helper/uuct_helper.sh
	touch /boot/config/plugins/user.scripts/scripts/uuct_helper/name
	echo "uuct_helper" > /boot/config/plugins/user.scripts/scripts/uuct_helper/name
	sed -i "72s/language='de'/language='en'/gI" /boot/config/plugins/user.scripts/scripts/uuct_helper/script
	echo "#############################################################################################"
	echo "Now please run the uuct_helper script in the user.scripts via the web interface."
	echo "#############################################################################################"	
else
    echo  "You are up to date "
	echo -e "\ninstalled version: $offline_version"
	echo -e "online version: $online_version"
	sleep 3
exit 1
fi
						break
                        ;;
                "beenden / exit")
                        break
                        ;;
                *) echo "invalid option / falsche eingabe $REPLAY";;
        esac
done