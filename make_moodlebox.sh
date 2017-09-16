#!/usr/bin/env bash
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script. If not, see <http:#www.gnu.org/licenses/>.
#
# Copyright (c) 2016 onwards Nicolas Martignoni <nicolas@martignoni.net>

# #############################################################################
# make_moodlebox.sh
# A bash script to build automatically a MoodleBox on a Raspberry Pi 3.
#
# Instructions:
# * Clone Rasbpian Stretch Lite on your microSD card
# * Login to your RPi with the user root: `ssh root@raspberrypi.local`
# * Launch the script
#
# Source: https://github.com/martignoni/make-moodlebox

# #############################################################################
# Change these variables to customize your build
#
# Sets the password that will be set for ALL admin settings of the MoodleBox.
GENERICPASSWORD="Moodlebox4$"
#
# Sets the language used to build the MoodleBox. Used to install the locale needed on the RPi
# and to set the default language of the Moodle installation.
# Use valid locale codes (see /usr/share/i18n/SUPPORTED).
LANGUAGE="fr_FR"
#
# Sets the country where you'll use your MoodleBox. Used to set the Wi-Fi access point settings.
# Use ISO 3166-1 alpha-2 two letter codes (see /usr/share/zoneinfo/iso3166.tab).
COUNTRY="CH"
#
# The timezone of the place where you'll use your MoodleBox.
# Use standard IANA time zone database identifiers (see output of timedatectl list-timezones).
TIMEZONE="Europe/Paris"
#
# #############################################################################
# Do NOT change anything under this line.
# You'll get ABSOLUTELY NO SUPPORT for any problems due to changes after this!

# Uncomment for debugging
#exec 1> >(logger -s -t $(basename $0)) 2>&1

# This script MUST be run as root
[[ $EUID -ne 0 ]] && { echo "This script must be run as root"; exit 1; }
# e.g. it can be launched from the root account like this
# curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox.sh | bash

# Version related variables
VERSION="1.9.3"
DATE="2017-09-11"

# The real thing begins here
export DEBIAN_FRONTEND="noninteractive"
export APT_LISTCHANGES_FRONTEND="none"

# http://unix.stackexchange.com/questions/145294/how-to-continue-a-script-after-it-reboots-the-machine
before_reboot(){
    # Script start!
    clear
    sync

    cat << "EOF" > /etc/init.d/makemoodlebox
#! /bin/sh
### BEGIN INIT INFO
# Provides:          makemoodlebox
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     3 4 5
# Default-Stop:
# Short-Description: Execute the makemoodlebox command.
# Description:
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
    start)
        curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox.sh | bash
        ;;
    *)
        echo "Usage: $0 start" >&2
        exit 3
        ;;
esac
EOF

    chmod a+x /etc/init.d/makemoodlebox

# stolen from https://github.com/RPi-Distro/pi-gen/blob/dev/stage2/01-sys-tweaks/files/resize2fs_once
    cat << "EOF" > /etc/init.d/resize2fs_once
#!/bin/sh
### BEGIN INIT INFO
# Provides:          resize2fs_once
# Required-Start:
# Required-Stop:
# Default-Start: 3
# Default-Stop:
# Short-Description: Resize the root filesystem to fill partition
# Description:
### END INIT INFO
. /lib/lsb/init-functions
case "$1" in
  start)
    log_daemon_msg "Starting resize2fs_once"
    ROOT_DEV=`grep -Eo 'root=[[:graph:]]+' /proc/cmdline | cut -d '=' -f 2-` &&
    resize2fs $ROOT_DEV &&
    update-rc.d resize2fs_once remove &&
    rm /etc/init.d/resize2fs_once &&
    log_end_msg $?
    ;;
  *)
    echo "Usage: $0 start" >&2
    exit 3
    ;;
esac
EOF

    chmod a+x /etc/init.d/resize2fs_once

    echo -e "\e[96mMake MoodleBox"
    echo -e "Author: Nicolas Martignoni"
    echo -e "Version: $VERSION, $DATE\n"

    # Configure important settings
    echo -e "\e[93mInstalling locale $LANGUAGE...\e[97m"
    ## Install locale
    # This uses the $LANGUAGE variable defined at the top of the script
    # Uncomment line containing $LANGUAGE.UTF-8 and generate locale
    sed -i "/^# $LANGUAGE.UTF-8/s/^# //" /etc/locale.gen
    dpkg-reconfigure -f noninteractive locales

    echo -e "\e[93mConfiguring timezone to $TIMEZONE...\e[97m"
    ## Change timezone
    # This uses the $TIMEZONE variable defined at the top of the script
    echo $TIMEZONE > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata

    echo -e "\e[93mConfiguring Wi-Fi country to $COUNTRY...\e[97m"
    ## Change WiFi country
    # This uses the $COUNTRY variable defined at the top of the script
    if grep -q "^country=" /etc/wpa_supplicant/wpa_supplicant.conf ; then
        sed -i "s/^country=.*/country=$COUNTRY/g" /etc/wpa_supplicant/wpa_supplicant.conf
    else
        sed -i "1i country=$COUNTRY" /etc/wpa_supplicant/wpa_supplicant.conf
    fi

    echo -e "\e[93mChanging hostname...\e[97m"
    ## Change hostname
    CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
    NEW_HOSTNAME=moodlebox
    echo $NEW_HOSTNAME > /etc/hostname
    sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/10.0.0.1\t$NEW_HOSTNAME.me/g" /etc/hosts

    # Rename default user from "pi" to "moodlebox"
    # http://unixetc.co.uk/2016/01/07/how-to-rename-the-default-raspberry-pi-user/
    echo -e "\e[93mRenaming default user to \"moodlebox\"...\e[97m"
    cd /etc
    # tar -czf /home/pi/authfiles.tgz passwd group shadow gshadow sudoers sudoers.d/* systemd/system/autologin@.service
    # sed -i.$(date +'%y%m%d_%H%M%S') 's/\bpi\b/moodlebox/g' passwd group shadow gshadow sudoers sudoers.d/* systemd/system/autologin@.service
    sed -i 's/\bpi\b/moodlebox/g' passwd group shadow gshadow sudoers sudoers.d/* systemd/system/autologin@.service
    mv /etc/sudoers.d/010_pi-nopasswd /etc/sudoers.d/010_moodlebox-nopasswd
    mv /home/pi /home/moodlebox
    ## Change user password
    echo "moodlebox:$GENERICPASSWORD" | chpasswd
    ## Add link to avoid some side effects after renaming the default user
    ln -s /home/moodlebox /home/pi

    # Reduce memory split down to 16Mb, as we are on a headless system
    echo -e "\e[93mReducing memory split down to 16Mb...\e[97m"
    echo "gpu_mem=16" >> /boot/config.txt

    # Turn off screen blanking
    echo -e "\e[93mTurning off screen blanking...\e[97m"
    sed -i 's/\bconsole=tty1\b/& consoleblank=0/' /boot/cmdline.txt

    ## Some bash configurations for default account
    cat << "EOF" >> /home/moodlebox/.bashrc

alias ll='ls -la'

# Assign arrow keys to history search in bash
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
# TAB cycles through the list of partial matches
bind 'TAB:menu-complete'
EOF

    sed -i '/PS1=.*01;32m.*01;34m.*/c\    PS1="${debian_chroot:+($debian_chroot)}\\[\\e[0;93m\\]\\u\\[\\e[0m\\]@\\[\\e[38;5;208m\\]\\h\\[\\e[0m\\]:\\[\\e[0;96m\\]\\w \\[\\e[0m\\]\\$ "' /home/moodlebox/.bashrc

    # Update system to latest stable release
    echo -e "\e[93mUpdating system to latest stable release...\e[97m"
    apt-get update && apt-get dist-upgrade -y
    ### We have to reboot here, and continue afterwards
}

after_reboot(){
    # mariadb-server preseed selections (http://dba.stackexchange.com/questions/59317/install-mariadb-10-on-ubuntu-without-prompt-and-no-root-password)
    debconf-set-selections <<< "mariadb-server mysql-server/root_password password $GENERICPASSWORD"
    debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $GENERICPASSWORD"

    # phpmyadmin preseed selections
    debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $GENERICPASSWORD"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $GENERICPASSWORD"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $GENERICPASSWORD"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"

    ## Configure automount
    echo -e "\e[93mAutomount configuration...\e[97m"
    cat >> /etc/fstab <<EOF
# Rules for automounting both at boot and upon USB plugin. Rely on udev rules
/dev/USBdrive  /media/USBdrive         auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive1 /media/USBdrive1        auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive2 /media/USBdrive2        auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive3 /media/USBdrive3        auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive4 /media/USBdrive4        auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive5 /media/USBdrive5        auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive6 /media/USBdrive6        auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive7 /media/USBdrive7        auto    defaults,noatime,auto,nofail    0       2
/dev/USBdrive8 /media/USBdrive8        auto    defaults,noatime,auto,nofail    0       2
EOF

    cat > /usr/local/etc/blknum <<'EOF'
#!/bin/bash

# we perform a cleanup with the first one
ls -d /dev/USBdrive* &>/dev/null || {
  rmdir /media/USBdrive*
  for f in `ls /media/`; do
    test -L $f && rm $f
  done
  exit 0
}

for i in `seq 1 1 8`; do
  test -e /media/USBdrive$i && continue
  echo $i
  exit 0
done

exit 1
EOF

    chmod +x /usr/local/etc/blknum

    # Create udev automount rules.
    cat > /etc/udev/rules.d/50-automount.rules <<'EOF'
# Need to be a block device
KERNEL!="sd[a-z][0-9]", GOTO="exit"

# Import some useful filesystem info as variables
IMPORT{program}="/sbin/blkid -o udev -p %N"

# Need to be a filesystem
ENV{ID_FS_TYPE}!="vfat|ntfs|ext4|iso9660", GOTO="exit"

# Create symlink that will be understood by fstab, and a directory in /media
ACTION!="remove", PROGRAM="/usr/local/etc/blknum", RUN+="/bin/mkdir -p /media/USBdrive%c", SYMLINK+="USBdrive%c"

# Get a label if present, otherwise specify one
ENV{ID_FS_LABEL}!="", ENV{dir_name}="%E{ID_FS_LABEL}"

# Link with label name if exists
ACTION=="add", ENV{ID_FS_LABEL}!="", ENV{ID_FS_LABEL}!="USBdrive*", RUN+="/bin/rm /media/%E{ID_FS_LABEL}", RUN+="/bin/ln -sT /media/USBdrive%c /media/%E{ID_FS_LABEL}"

# Exit
LABEL="exit"
EOF

    ## Install all packages needed for the whole process
    echo -e "\e[93mPackages installation...\e[97m"
    apt-get install -y iptables-persistent hostapd dnsmasq git incron certbot
    echo root > /etc/incron.allow
    apt-get install -y mariadb-server
    # install nginx 1.10 and php 7.0
    apt-get install -y nginx php7.0-fpm php7.0-cli php7.0-xmlrpc php7.0-curl php7.0-gd php7.0-intl php7.0-soap php7.0-mysql php-apcu

    # configure MariaDB server parameters
    sed -i '/table_cache/c\table_cache             = 512' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/table_cache/a table_definition_cache  = 512' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/max_connections/c\max_connections         = 100' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/query_cache_size/c\query_cache_size    = 16M' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/query_cache_size/a query_cache_type    = 0' /etc/mysql/mariadb.conf.d/50-server.cnf
    # configure MariaDB InnoDB parameters (encodings are already OK on 10.1.21-5, Debian Stretch)
    # see https://mathiasbynens.be/notes/mysql-utf8mb4
    # see https://docs.moodle.org/33/en/MySQL_full_unicode_support
    sed -i '/# Read the manual for more InnoDB related options/a \innodb_file_format = Barracuda' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/innodb_file_format/a \innodb_file_per_table = 1' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/innodb_file_per_table/a \innodb_large_prefix' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/innodb_large_prefix/a \innodb_log_file_size = 64M' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/innodb_log_file_size/a \innodb_buffer_pool_instances = 1' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/innodb_buffer_pool_instances/a \innodb_buffer_pool_size = 128M' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i '/collation-server/a \character-set-client-handshake = FALSE' /etc/mysql/mariadb.conf.d/50-server.cnf

    ## Create database user for Moodle and phpMyAdmin
    echo -e "\e[93mDatabase user creation...\e[97m"
    mysql -t << STOP
CREATE USER 'moodlebox'@'localhost' IDENTIFIED BY '$GENERICPASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'moodlebox'@'localhost';
FLUSH PRIVILEGES;
\q
STOP

    ## Restart MariaDB
    systemctl restart mariadb

    # install phpMyAdmin
    apt-get install -y phpmyadmin

    ## Access point and network configuration: edit configuration files
    echo -e "\e[93mAccess point and network configuration...\e[97m"
    # 1. /etc/dhcpcd.conf
    cat << "EOF" >> /etc/dhcpcd.conf

denyinterfaces wlan0
EOF

    # 2. /etc/network/interfaces
    cat << "EOF" > /etc/network/interfaces
# interfaces(5) file used by ifup(8) and ifdown(8)

# Please note that this file is written to be used with dhcpcd
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
iface eth0 inet6 auto

allow-hotplug wlan0
iface wlan0 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    network 10.0.0.0
    broadcast 10.0.0.255

allow-hotplug wlan1
iface wlan1 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
EOF

    # 3. /etc/hostapd/hostapd.conf
    cat << EOF > /etc/hostapd/hostapd.conf
# Set country code
country_code=$COUNTRY
# Name of the Wi-Fi interface
interface=wlan0
# Use the nl80211 driver
driver=nl80211
# Wi-Fi network name (SSID)
ssid=MoodleBox
# Use the 2.4GHz band
hw_mode=g
# Use channel 11
channel=11
# Enable 802.11n
ieee80211n=1
# Enable WMM
wmm_enabled=1
# Enable 40 MHz channels with short guard interval for 20 Mhz
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
# Accept all MAC addresses
macaddr_acl=0
# Use WPA authentication
auth_algs=1
# Use WPA2
wpa=2
# Use a pre-shared key
wpa_key_mgmt=WPA-PSK
# The network passphrase
wpa_passphrase=moodlebox
# Use AES, instead of TKIP
rsn_pairwise=CCMP
# Enable hostapd_cli
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0
EOF

    sed -i '/#DAEMON_CONF/c\DAEMON_CONF="/etc/hostapd/hostapd.conf"' /etc/default/hostapd

    # 4. /etc/dnsmasq.conf
    cat << "EOF" > /etc/dnsmasq.conf
interface=wlan0             # Use interface wlan0
listen-address=127.0.0.1    # Explicitly specify the address to listen on
listen-address=10.0.0.1     # Explicitly specify the address to listen on
bind-interfaces             # Make sure we aren't sending things elsewhere
server=209.244.0.3          # Forward DNS requests to Level3 DNS
server=209.244.0.4          # Forward DNS requests to Level3 DNS
domain-needed               # Don't forward short names
bogus-priv                  # Don't forward addresses in the non-routed spaces
domain=moodlebox.me         # Set private domain name to 'moodlebox.me'
local=/moodlebox.me/        # Don't forward queries for private domain 'moodlebox.me'
expand-hosts                # Add private domain name to hostnames
dhcp-range=wifi,10.0.0.10,10.0.0.254,255.255.255.0,4h # Assign IP addresses with 4h lease, subnet name 'wifi'
dhcp-option=wifi,6,10.0.0.1 # Set DNS server for subnet wifi
txt-record=moodlebox.me,"MoodleBox by Nicolas Martignoni"
# log-facility=/var/log/dnsmasq.log # Enable log
EOF

    # 5. /etc/sysctl.conf
    sed -i '/#net.ipv4.ip_forward/c\net.ipv4.ip_forward=1' /etc/sysctl.conf

    # 6. /etc/iptables.ipv4.nat
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

    # 7. /etc/avahi/services/moodlebox.service (Advertise mDNS services)
    cat << "EOF" > /etc/avahi/services/moodlebox.service
<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_device-info._tcp</type>
    <port>0</port>
    <txt-record>model=MoodleBox</txt-record>
  </service>
  <service>
    <type>_ssh._tcp</type>
    <port>22</port>
  </service>
  <service>
    <type>_sftp-ssh._tcp</type>
    <port>22</port>
  </service>
  <service>
    <type>_http._tcp</type>
    <port>80</port>
  </service>
</service-group>
EOF

    ## Edit web server configuration
    echo -e "\e[93mWebserver (nginx) configuration...\e[97m"
    cat << "EOF" > /etc/nginx/sites-available/default
# Default server configuration
#
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/moodle;

  index index.php index.html index.htm index.nginx-debian.html;

  server_name moodlebox;

  location / {
    try_files $uri $uri/ =404;
  }

  location /dataroot/ {
    internal;
    alias /var/www/moodledata/;
  }

  location ~ [^/]\.php(/|$) {
    include fastcgi_params;
    fastcgi_split_path_info	^(.+\.php)(/.+)$;
    fastcgi_read_timeout	300;
    fastcgi_pass	unix:/var/run/php/php7.0-fpm.sock;
    fastcgi_index	index.php;
    fastcgi_param	PATH_INFO	$fastcgi_path_info;
    fastcgi_param	SCRIPT_FILENAME	$document_root$fastcgi_script_name;
    fastcgi_param	PHP_VALUE	"max_execution_time=300\n upload_max_filesize=50M\n post_max_size=50M";
    client_max_body_size	50M;
  }

}
EOF

    ## Create database for Moodle
    echo -e "\e[93mMySQL and Moodle database configuration...\e[97m"
    mysql -t << STOP
CREATE DATABASE moodle;
GRANT ALL ON moodle.* TO 'moodlebox'@'localhost' IDENTIFIED BY '$GENERICPASSWORD';
FLUSH PRIVILEGES;
\q
STOP

    ## Download Moodle via git and create all needed directories, with adequate permissions
    echo -e "\e[93mDownloading Moodle 3.3.x via Git and directories configuration...\e[97m"
    cd /var/www/
    rm -r html
    git clone --depth=1 -b MOODLE_33_STABLE git://git.moodle.org/moodle.git moodle
    mkdir -p /var/www/moodledata/repository
    chown -R www-data:www-data /var/www/moodle /var/www/moodledata/
    chmod -R ug+w,o-w /var/www/moodle /var/www/moodledata/

    mkdir -p /home/moodlebox/files
    chown -R moodlebox:www-data /home/moodlebox/files
    chmod g+s /home/moodlebox/files
    ln -s /home/moodlebox/files /var/www/moodledata/repository
    ln -s /media/USBdrive /var/www/moodledata/repository/usb

    ln -s /usr/share/phpmyadmin /var/www/moodle/phpmyadmin

    ## Configure RAM disk for Moodle cache
    mkdir -p /var/cache/moodle
    mkdir -p /var/cache/moodle-cache-backup
    chown www-data:www-data /var/cache/moodle

    cat << "EOF" >> /etc/fstab
tmpfs /var/cache/moodle tmpfs size=64M,mode=775,uid=www-data,gid=www-data 0 0
tmpfs /var/www/moodledata/temp tmpfs size=128M,mode=775,uid=www-data,gid=www-data 0 0
tmpfs /var/www/moodledata/sessions tmpfs size=16M,mode=775,uid=www-data,gid=www-data 0 0
EOF

    ## Install Moodle via cli
    echo -e "\e[93mMoodle installation (via CLI)...\e[97m"
    # Summary to be displayed on the front page
    SUMMARY="<p><span lang='en' class='multilang'><a href='https://moodlebox.net/' target='_blank'>MoodleBox</a>, a <a href='https://moodle.org/' target='_blank'>Moodle 3.3.x</a> platform on <a href='https://www.raspberrypi.org/' target='_blank'>Raspberry Pi&nbsp;3</a>.</span><span lang='fr' class='multilang'><a href='https://moodlebox.net/' target='_blank'>MoodleBox</a>, une plateforme <a href='https://moodle.org/' target='_blank'>Moodle 3.3.x</a> sur <a href='https://www.raspberrypi.org/' target='_blank'>Raspberry Pi&nbsp;3</a>.</span></p>
    <p><span lang='en' class='multilang'>MoodleBox is made by <a href='mailto:nicolas@martignoni.net'>Nicolas Martignoni</a>.</span><span lang='fr' class='multilang'>MoodleBox est réalisée par <a href='mailto:nicolas@martignoni.net'>Nicolas Martignoni</a>.</span></p>
    <p><span lang='en' class='multilang'>Version $VERSION, $(LC_ALL=en_GB.utf8 date --date $DATE '+%d %B %Y').</span><span lang='fr' class='multilang'>Version $VERSION, $(LC_ALL=fr_FR.utf8 date --date $DATE '+%d %B %Y').</span></p>"
    # Start installation
    /usr/bin/php "/var/www/moodle/admin/cli/install.php" \
      --lang=$(echo $LANGUAGE | cut -d"_" -f 1) \
      --wwwroot="http://moodlebox.me" \
      --dataroot="/var/www/moodledata" \
      --dbtype="mariadb" \
      --dbname="moodle" \
      --prefix="mdl_" \
      --dbuser="moodlebox" \
      --dbpass="$GENERICPASSWORD" \
      --fullname="MoodleBox" \
      --shortname="MoodleBox" \
      --summary="$SUMMARY" \
      --adminuser=admin \
      --adminpass="$GENERICPASSWORD" \
      --adminemail="admin@moodlebox.invalid" \
      --non-interactive \
      --agree-license
    sed -i "/$CFG->directorypermissions/i \$CFG->xsendfile = 'X-Accel-Redirect';\n\$CFG->xsendfilealiases = array ('/dataroot/' => \$CFG->dataroot);\n" /var/www/moodle/config.php
    chown www-data:www-data /var/www/moodle/config.php
    /usr/bin/php /var/www/moodle/admin/cli/mysql_compressed_rows.php -f

    ## Install last stable version of MoodleBox Admin Moodle plugin
    echo -e "\e[93mMoodleBox plugin installation (via CLI)...\e[97m"
    cd /var/www/moodle/admin/tool/
    git clone https://github.com/martignoni/moodle-tool_moodlebox.git moodlebox
    cd /var/www/moodle/admin/tool/moodlebox
    # Get latest published tag (see https://gist.github.com/rponte/fdc0724dd984088606b0)
    LASTTAG=$(git describe --abbrev=0 --tags)
    git checkout tags/$LASTTAG
    touch .reboot-server; touch .shutdown-server; touch .set-server-datetime; touch .newpassword; touch .wifisettings
    chown -R www-data:www-data /var/www/moodle/admin/tool/moodlebox
    chmod -R ug+w,o-w /var/www/moodle/admin/tool/moodlebox

    /usr/bin/php "/var/www/moodle/admin/cli/upgrade.php" --non-interactive

    # Cron and incron jobs configuration
    echo -e "\e[93mCron and incron jobs configuration...\e[97m"
    ## Configure incron jobs (for restart/shutdown from web interface)
    (incrontab -l -u root 2>/dev/null; echo "/var/www/moodle/admin/tool/moodlebox/.reboot-server IN_CLOSE_WRITE /sbin/shutdown -r now") | incrontab -
    (incrontab -l -u root 2>/dev/null; echo "/var/www/moodle/admin/tool/moodlebox/.shutdown-server IN_CLOSE_WRITE /sbin/shutdown -h now") | incrontab -
    (incrontab -l -u root 2>/dev/null; echo "/var/www/moodle/admin/tool/moodlebox/.set-server-datetime IN_CLOSE_WRITE /bin/bash /var/www/moodle/admin/tool/moodlebox/.set-server-datetime") | incrontab -
    (incrontab -l -u root 2>/dev/null; echo "/var/www/moodle/admin/tool/moodlebox/.newpassword IN_CLOSE_WRITE /bin/bash /var/www/moodle/admin/tool/moodlebox/bin/changepassword.sh") | incrontab -
    (incrontab -l -u root 2>/dev/null; echo "/var/www/moodle/admin/tool/moodlebox/.wifisettings IN_CLOSE_WRITE /bin/bash /var/www/moodle/admin/tool/moodlebox/bin/changewifisettings.sh") | incrontab -

    ## Configure cron jobs
    (crontab -l -u root 2>/dev/null; echo "*/3 * * * * nice -n 10 ionice -c2 /usr/bin/php /var/www/moodle/admin/cli/cron.php") | crontab -
    (crontab -l -u root 2>/dev/null; echo "*/20 * * * * rsync -a --delete /var/cache/moodle/ /var/cache/moodle-cache-backup/") | crontab -
    (crontab -l -u root 2>/dev/null; echo "@reboot cp -Rpf /var/cache/moodle-cache-backup/* /var/cache/moodle/") | crontab -

    ## Cleanup tasks
    echo -e "\e[93mCleaning up...\e[97m"
    rm -rf /var/www/moodledata/cache/*
    rm -rf /var/www/moodledata/localcache/*
    rm -rf /var/www/moodledata/temp/*
    rm -rf /var/www/moodledata/trashdir/*
    rm -rf /var/www/moodledata/sessions/*
    rm -rf /var/cache/moodle/*
    rm -rf /var/cache/moodle-cache-backup/*
    mysql -e "truncate table moodle.mdl_logstore_standard_log"
    mysql -e "truncate table moodle.mdl_config_log"
    mysql -e "truncate table moodle.mdl_upgrade_log"
    apt-get autoremove -y
    apt-get clean
    rm -rf /var/lib/apt/lists/*
    rm -rf /var/cache/debconf/*
    rm -rf /tmp/*
    rm -rf /var/tmp/*
    rm -f ~/.mysql_history
    rm -f ~/.nano_history
    rm -f ~/.bash_history
    sudo bash -c 'for logs in `find /var/log -type f`; do > $logs; done'
    rm -rf /root/.ssh
    truncate -s 0 /root/.bash_history
    systemctl stop dnsmasq
    truncate -s 0 /var/lib/misc/dnsmasq.leases
    apt-get --purge autoremove
}

if [ -f /root/rebooting-for-secondstep ]; then
    after_reboot
    rm /root/rebooting-for-secondstep
    rm /etc/init.d/makemoodlebox
    update-rc.d makemoodlebox remove
    reboot
else
    before_reboot
    touch /root/rebooting-for-secondstep
    update-rc.d makemoodlebox defaults
    reboot
fi
# #############################################################################
# The end
