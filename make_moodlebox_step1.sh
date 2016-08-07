#!/usr/bin/env bash

# This script MUST be run as root
[ "$(whoami)" == "root" ] || { echo "Must be run as sudo!"; exit 1; }

# e.g. it could be launched like this
# curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox_step1.sh | sudo bash

# Script start!
clear
sync

echo -e "\e[96mMake MoodleBox, first step"
echo -e "Author: Nicolas Martignoni"
echo -e "Version: 1.0\n\e[97m"

# Copy SSH keys to root account
echo -e "\e[93mCopying SSH keys to root account...\e[94m"
mkdir /root/.ssh/
cat << "EOF" > /root/.ssh/authorized_keys
ssh-dss AAAAB3NzaC1kc3MAAACBANUzp1IPYgFP6GqnmIjtW7IRL0Wakn8TDD12nLNTEtyz6anGcuuuP6VyZIw0lLEKMf3Al+9j+u4dP66o7xwLtm1vvqtgKppEf+Yo9isb50Jj6dXIB3kYpmcWseV5qtQX78Yui7+DXHZ8ow6zxXbTHzx+mdMJm4ebLQbdLpAhRRHLAAAAFQDzz4F+03vlY5lPVT9ZLsA/MBcCoQAAAIBz5FEnqAMwzQekk7Ljr+yuIcYMBS974nJzT9ZcJoXVEL/uhVvzRiprFrID1/7DwruIXAJSImHW34jwqCGoSHj0fkCcsHIh/KOuJOwGaRbbW3kfIu4+1yZoQovQdxREjTLEJSKBLqEghRB+RcDRp38yHfUfi3kfDWOPYbULO0sNsgAAAIEAs8MTEMOZtke8ICfL3KyV3wprBrUEG3H4QhqsJWdYVU7Y/0XZ6fN9YOWFNAs94MYg/b/RnPT5kRqXq3u5NttMfgg7gnV7Xuh0ik7HtOd5D4uM+o0Xyq+j/eBqxXSizaapDvspkkhFcOtSSf2hZdeHpKvan+PaKmpBm0Vx8PhKgAo= nicolas@Martignoni.local.
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAkfAVq+GubMYwgEktSbJJJDcqr7GvJ4nJS6wDVkjeHGVqIt0LqsJMHTdSexT6mglu/3A2nIozyc3VkK1XKsfg821HsupTV6cdDp7dRuysxkJfV3FRq3dV6X3ohY/fO7QYtkAHPjYqss5hr+Fs6uUGU8PbMpcsT+E6CktZenETUR0= nicolas@Martignoni.local.
EOF

# Update system to latest stable release
echo -e "\e[93mUpdating system to latest stable release...\e[94m"
apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get upgrade -y

# Configure important settings (done via raspi-config when GUI used)
echo -e "\e[93mConfiguring important settings...\e[94m"
## Change user password
echo "moodlebox:Moodlebox4$" | chpasswd
## Change locale
# # Comment all uncommented lines, then uncomment line fr_FR.UTF-8 in /etc/locale.gen
# sed -i "/^#/! {/./ s/^#*/# /}" /etc/locale.gen
# sed -i "/fr_FR.UTF-8/c\fr_FR.UTF-8 UTF-8" /etc/locale.gen
# dpkg-reconfigure -f noninteractive locales
# update-locale LANG=fr_FR.UTF-8
# Maybe better way to do it using debconf
echo "locales locales/locales_to_be_generated multiselect fr_FR.UTF-8 UTF-8" | debconf-set-selections
echo "locales locales/default_environment_locale select fr_FR.UTF-8" | debconf-set-selections
dpkg-reconfigure -f noninteractive locales
## Change timezone
# echo "Europe/Paris" > /etc/timezone
# Maybe better way to do it using debconf
echo "tzdata tzdata/Areas select Europe" | debconf-set-selections
echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections
dpkg-reconfigure -f noninteractive tzdata
## Change WiFi country
COUNTRY=CH
if grep -q "^country=" /etc/wpa_supplicant/wpa_supplicant.conf ; then
    sed -i "s/^country=.*/country=$COUNTRY/g" /etc/wpa_supplicant/wpa_supplicant.conf
else
    sed -i "1i country=$COUNTRY" /etc/wpa_supplicant/wpa_supplicant.conf
fi
## Change hostname
CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=moodlebox
echo $NEW_HOSTNAME > /etc/hostname
sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
## Expand filesystem
# TODO
echo -e "\e[93mYou should now expand your file system. Wait for raspi-config"
echo -e "and select the appropriate options. You'll be then prompted to reboot.\e[94m"
sleep 3
raspi-config
## End