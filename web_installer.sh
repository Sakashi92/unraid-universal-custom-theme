#!/bin/sh
echo "#############################################################################################"
echo "Bei einem Update gehen alle selbstgemachte einstellungen verloren,"
echo "sichere vorher deine Hexwerte seperat um die Farben wiederherzustellen"
echo "Du hast 10 sec zeit das Script mit strg + c abzubrechen!"
echo "#############################################################################################"
sleep 1
echo "10..."
sleep 1
echo "9..."
sleep 1
echo "8..."
sleep 1
echo "7..."
sleep 1
echo "6..."
sleep 1
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
wget -P /boot/config/plugins/user.scripts/scripts/uuct_installer https://raw.githubusercontent.com/Sakashi92/unraid-universal-custom-theme/dev/uuct.sh
mv /boot/config/plugins/user.scripts/scripts/uuct_installer/uuct.sh /boot/config/plugins/user.scripts/scripts/uuct_installer/script
touch /boot/config/plugins/user.scripts/scripts/uuct_installer/name
echo "uuct_installer" > /boot/config/plugins/user.scripts/scripts/uuct_installer/name
echo "#############################################################################################"
echo "Führe bitte jetzt das Script uuct_installer in den user.scripts über die Weboberfläche aus."
echo "#############################################################################################"