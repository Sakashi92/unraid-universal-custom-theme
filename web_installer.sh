#!/bin/sh
wget -P /boot/config/plugins/user.scripts/scripts/uuct_installer https://raw.githubusercontent.com/Sakashi92/unraid-universal-custom-theme/dev/uuct.sh
mv /boot/config/plugins/user.scripts/scripts/uuct_installer/uuct.sh /boot/config/plugins/user.scripts/scripts/uuct_installer/script
touch /boot/config/plugins/user.scripts/scripts/uuct_installer/name
echo "uuct_installer" > /boot/config/plugins/user.scripts/scripts/uuct_installer/name
echo "#############################################################################################"
echo "Führe bitte jetzt das Script uuct_installer in den user.scripts über die Weboberfläche aus."
echo "#############################################################################################"