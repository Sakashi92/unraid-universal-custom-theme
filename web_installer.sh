#!/bin/sh
echo "#############################################################################################"
echo "Bei einem Update gehen alle selbstgemachten Einstellungen nicht verloren,"
echo "jedoch kann ich dir nicht garantieren das meine Backup und wiederherstellungsfuntkion"
echo "reibungslos funktionieren, dies ist noch eine experimentelle Funktion."
echo "Sichere vorher deine hexwerte seperat um die Farben wiederherzustellen"
echo "Dies gilt nur ab einer Script Version von 0.5. Alles darunter unterstützt kein Backup."
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
sleep 1
echo "#############################################################################################"
echo "Daten werden nun heruntergeladen und vorhandene überschrieben"
echo "#############################################################################################"
sleep 1
wget -P /boot/config/plugins/user.scripts/scripts/uuct_installer https://raw.githubusercontent.com/Sakashi92/unraid-universal-custom-theme/dev/uuct.sh
mv /boot/config/plugins/user.scripts/scripts/uuct_installer/uuct.sh /boot/config/plugins/user.scripts/scripts/uuct_installer/script
touch /boot/config/plugins/user.scripts/scripts/uuct_installer/name
echo "uuct_installer" > /boot/config/plugins/user.scripts/scripts/uuct_installer/name
echo "#############################################################################################"
echo "Führe bitte jetzt das Script uuct_installer in den user.scripts über die Weboberfläche aus."
echo "#############################################################################################"