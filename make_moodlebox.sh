#!/usr/bin/env bash

# This script MUST be run as root
[[ $EUID -ne 0 ]] && { echo "This script must be run as root"; exit 1; }

# e.g. it could be launched from the root account like this
# curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox.sh | sudo bash

GENERICPASSWORD="Moodlebox4$"
export DEBIAN_FRONTEND="noninteractive"

cat << "EOF" > /etc/init.d/makemoodlebox
#! /bin/bash
### BEGIN INIT INFO
# Provides:          makemoodlebox
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
    start)
        curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox.sh | bash
        ;;
    stop|status|restart|reload|force-reload)
        echo "Error: argument '$1' not supported" >&2
        exit 3
        ;;
esac
EOF

before_reboot(){
    # Script start!
    clear
    sync

    echo -e "\e[96mMake MoodleBox"
    echo -e "Author: Nicolas Martignoni"
    echo -e "Version: 1.0\n"

    # Configure important settings (done via raspi-config when GUI used)
    echo -e "\e[93mConfiguring important settings...\e[97m"
    ## Change locale
    export LANG=fr_FR.UTF-8
    # Comment all uncommented lines, then uncomment line fr_FR.UTF-8 in /etc/locale.gen
    sed -i "/^#/! {/./ s/^#*/# /}" /etc/locale.gen
    sed -i "/fr_FR.UTF-8/c\fr_FR.UTF-8 UTF-8" /etc/locale.gen
    dpkg-reconfigure -f noninteractive locales
    update-locale LANG=fr_FR.UTF-8
    ## Change timezone
    echo "Europe/Paris" > /etc/timezone
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

    # Rename default user from "pi" to "moodlebox"
    # http://unixetc.co.uk/2016/01/07/how-to-rename-the-default-raspberry-pi-user/
    echo -e "\e[93mRenaming default user to \"moodlebox\"...\e[97m"
    cd /etc
    # tar -czf /home/pi/authfiles.tgz passwd group shadow gshadow sudoers systemd/system/autologin@.service
    sed -i.$(date +'%y%m%d_%H%M%S') 's/\bpi\b/moodlebox/g' passwd group shadow gshadow sudoers systemd/system/autologin@.service
    mv /home/pi /home/moodlebox
    ## Change user password
    echo "moodlebox:$GENERICPASSWORD" | chpasswd

    ## Remove logging to /dev/xconsole from the default rsyslog configuration
    # https://anonscm.debian.org/cgit/collab-maint/rsyslog.git/commit/?id=67bc8e5326b0d3564c7e2153dede25f9690e6839
    sed -i '/# The named pipe \/dev\/xconsole/,$d' /etc/rsyslog.conf
    service rsyslog restart

    ## Some bash configurations for default account
    cat << "EOF" >> /home/moodlebox/.bashrc

alias ll='ls -la'

# Assign arrow keys to history search in bash
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
# TAB cycles through the list of partial matches
bind 'TAB:menu-complete'
    EOF

    # Update system to latest stable release
    echo -e "\e[93mUpdating system to latest stable release...\e[97m"
    apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get upgrade -y
    ### We have to reboot here, and continue afterwards
}

after_reboot(){
    # mysql-server preseed selections (https://serversforhackers.com/video/installing-mysql-with-debconf)
    debconf-set-selections <<< "mysql-server mysql-server/root_password password $GENERICPASSWORD"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $GENERICPASSWORD"

    # phpmyadmin preseed selections
    debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $GENERICPASSWORD"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $GENERICPASSWORD"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $GENERICPASSWORD"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
    debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"

    ## Install all packages needed for the whole process
    echo -e "\e[93mPackages installation...\e[97m"
    apt-get install -y hostapd dnsmasq nginx php5-fpm php5-cli php5-xmlrpc php5-curl php5-gd php5-intl mysql-server php5-mysql git usbmount incron
    echo root > /etc/incron.allow
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

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback

iface eth0 inet manual

allow-hotplug wlan0
iface wlan0 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    network 10.0.0.0
    broadcast 10.0.0.255
#    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

allow-hotplug wlan1
iface wlan1 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
    EOF

    # 3. /etc/hostapd/hostapd.conf
    cat << "EOF" > /etc/hostapd/hostapd.conf
# Name of the Wi-Fi interface
interface=wlan0
# Use the nl80211 driver
driver=nl80211
# Wi-Fi network name
ssid=MoodleBox
# Use the 2.4GHz band
hw_mode=g
# Use channel 10
channel=10
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
    EOF

    sed -i '/#DAEMON_CONF/c\DAEMON_CONF="/etc/hostapd/hostapd.conf"' /etc/default/hostapd

    # 4. /etc/dnsmasq.conf
    cat << "EOF" > /etc/dnsmasq.conf
interface=wlan0         # Use interface wlan0
listen-address=10.0.0.1 # Explicitly specify the address to listen on
bind-interfaces         # Make sure we aren't sending things elsewhere
server=8.8.8.8          # Forward DNS requests to Google DNS
server=8.8.4.4          # Forward DNS requests to Google DNS
domain-needed           # Don't forward short names
bogus-priv              # Don't forward addresses in the non-routed spaces
# Assign IP addresses between 10.0.0.100 and 10.0.0.199 with 12 h lease time
dhcp-range=10.0.0.100,10.0.0.199,255.255.255.0,12h
# log-facility=/var/log/dnsmasq.log # Enable log
    EOF

    # 5. /etc/sysctl.conf
    sed -i '/#net.ipv4.ip_forward/c\net.ipv4.ip_forward=1' /etc/sysctl.conf

    # 6. /etc/iptables.ipv4.nat
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
    sh -c "iptables-save > /etc/iptables.ipv4.nat"
    sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

    # 7. /lib/dhcpcd/dhcpcd-hooks/70-ipv4-nat
    cat << "EOF" > /lib/dhcpcd/dhcpcd-hooks/70-ipv4-nat
iptables-restore < /etc/iptables.ipv4.nat
    EOF

    # 8. /etc/avahi/services/moodlebox.service (Advertise mDNS services)
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

  root /var/www/html;

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
    fastcgi_pass	unix:/var/run/php5-fpm.sock;
    fastcgi_index	index.php;
    fastcgi_param	PATH_INFO	$fastcgi_path_info;
    fastcgi_param	SCRIPT_FILENAME	$document_root$fastcgi_script_name;
    fastcgi_param	PHP_VALUE "upload_max_filesize = 50M \n post_max_size=50M";
    client_max_body_size	50M;
  }

}
    EOF

    ## Create database for Moodle and configure MySQL vars
    echo -e "\e[93mMySQL and Moodle database configuration...\e[97m"
    mysql -u root -p$GENERICPASSWORD -t << STOP
create database moodle;
grant all on moodle.* to 'root'@'localhost' identified by '$GENERICPASSWORD';
\q
    STOP

    sed -i '/table_cache/c\table_cache             = 512' /etc/mysql/my.cnf
    sed -i '/table_cache/i table_definition_cache  = 512' /etc/mysql/my.cnf
    sed -i '/max_connections/c\max_connections         = 100' /etc/mysql/my.cnf
    sed -i '/query_cache_size/c\query_cache_size        = 8M' /etc/mysql/my.cnf
    sed -i '/query_cache_size/i query_cache_type        = 0' /etc/mysql/my.cnf

    ## Download Moodle via git and create all needed directories, with adequate permissions
    echo -e "\e[93mDownloading Moodle 3.1.x via Git and directories configuration...\e[97m"
    cd /var/www/
    git clone git://git.moodle.org/moodle.git
    cd moodle
    git checkout MOODLE_31_STABLE
    cd ..
    rm -r html
    mv moodle html
    chown -R www-data:www-data /var/www/html
    mkdir /var/www/moodledata
    mkdir -p /var/www/moodledata/repository
    chown -R www-data:www-data /var/www/moodledata/

    mkdir -p /home/moodlebox/files
    chown -R moodlebox:www-data /home/moodlebox/files
    chmod g+s /home/moodlebox/files
    ln -s /home/moodlebox/files /var/www/moodledata/repository
    ln -s /media/usb /var/www/moodledata/repository

    ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

    ## Configure RAM disk for Moodle cache
    mkdir -p /var/cache/moodle
    mkdir -p /var/cache/moodle-cache-backup
    chown www-data:www-data /var/cache/moodle

    cat << "EOF" >> /etc/fstab
tmpfs /var/cache/moodle tmpfs size=64M,mode=775,uid=www-data,gid=www-data 0 0
tmpfs /var/www/moodledata/temp tmpfs size=64M,mode=775,uid=www-data,gid=www-data 0 0
tmpfs /var/www/moodledata/sessions tmpfs size=32M,mode=775,uid=www-data,gid=www-data 0 0
    EOF

    ## Install Moodle via cli
    echo -e "\e[93mMoodle installation (via CLI)...\e[97m"
    /usr/bin/php "/var/www/html/admin/cli/install.php" \
      --lang=fr \
      --wwwroot="http://moodlebox.local" \
      --dataroot="/var/www/moodledata" \
      --dbname="moodle" \
      --prefix="mdl_" \
      --dbuser="root" \
      --dbpass="$GENERICPASSWORD" \
      --fullname="MoodleBox" \
      --shortname="MoodleBox" \
      --adminuser=admin \
      --adminpass="$GENERICPASSWORD" \
      --non-interactive \
      --agree-license
    sed -i "/$CFG->directorypermissions/i \$CFG->xsendfile = 'X-Accel-Redirect';\n\$CFG->xsendfilealiases = array ('/dataroot/' => \$CFG->dataroot);\n" /var/www/html/config.php
    chown www-data:www-data /var/www/html/config.php
    /usr/bin/php /var/www/html/admin/cli/mysql_compressed_rows.php -f

    ## Install MoodleBox Admin Moodle plugin
    echo -e "\e[93mMoodleBox plugin installation (via CLI)...\e[97m"
    cd /var/www/html/local
    git clone https://github.com/martignoni/moodlebox.git
    cd /var/www/html/local/moodlebox
    touch .reboot-server; touch .shutdown-server; touch .set-server-datetime
    chown -R www-data:www-data /var/www/html/local/moodlebox

    /usr/bin/php "/var/www/html/admin/cli/upgrade.php" --non-interactive

    # Cron and incron jobs configuration
    echo -e "\e[93mCron and incron jobs configuration...\e[97m"
    ## Configure incron jobs (for restart/shutdown from web interface)
    (incrontab -l -u root 2>/dev/null; echo "/var/www/html/local/moodlebox/.reboot-server IN_CLOSE_WRITE /sbin/shutdown -r now") | incrontab -
    (incrontab -l -u root 2>/dev/null; echo "/var/www/html/local/moodlebox/.shutdown-server IN_CLOSE_WRITE /sbin/shutdown -h now") | incrontab -
    (incrontab -l -u root 2>/dev/null; echo "/var/www/html/local/moodlebox/.set-server-datetime IN_MODIFY /bin/bash /var/www/html/local/moodlebox/.set-server-datetime") | incrontab -

    ## Configure cron jobs
    (crontab -l -u root 2>/dev/null; echo "*/3 * * * * nice -n 10 ionice -c2 /usr/bin/php /var/www/html/admin/cli/cron.php") | crontab -
    (crontab -l -u root 2>/dev/null; echo "*/20 * * * * rsync -a --delete /var/cache/moodle/ /var/cache/moodle-cache-backup/") | crontab -
    (crontab -l -u root 2>/dev/null; echo "@reboot cp -Rpf /var/cache/moodle-cache-backup/* /var/cache/moodle/") | crontab -

    ## Cleanup tasks
    echo -e "\e[93mCleaning up...\e[97m"
    rm -r /var/www/moodledata/cache/*
    rm -r /var/www/moodledata/localcache/*
    rm -r /var/www/moodledata/temp/*
    rm -r /var/www/moodledata/trashdir/*
    rm -r /var/www/moodledata/sessions/*
    rm -r /var/cache/moodle/*
    rm -r /var/cache/moodle-cache-backup/*
    mysql -u root -p$GENERICPASSWORD moodle -e "truncate table moodle.mdl_logstore_standard_log"
    mysql -u root -p$GENERICPASSWORD moodle -e "truncate table moodle.mdl_config_log"
    apt-get clean
    rm -r /var/cache/debconf/*
    rm -r /tmp/*
    rm -r /var/tmp/*
    rm ~/.mysql_history
    rm ~/.nano_history
    sudo bash -c 'for logs in `find /var/log -type f`; do > $logs; done'

    ## Expand filesystem
    # TODO
    echo -e "\e[93mYou should now expand your file system. Wait for raspi-config"
    echo -e "and select the appropriate options. You'll be then prompted to reboot.\e[97m"
    sleep 2
    raspi-config
}

if [ -f /var/run/rebooting-for-updates ]; then
    after_reboot
    rm /var/run/rebooting-for-updates
    update-rc.d makemoodlebox remove
else
    before_reboot
    touch /var/run/rebooting-for-updates
    update-rc.d makemoodlebox defaults
    sudo reboot
fi
## The end