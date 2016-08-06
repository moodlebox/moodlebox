#!/usr/bin/env bash
# This script MUST be run as root

# ### Step 2 : login as root, change main user name, pi -> moodlebox
#
# ssh root@moodlebox.local

# Copy and paste the following command
curl -L https://raw.githubusercontent.com/martignoni/moodlebox-install/master/make_moodlebox_step2.sh?token=AAZuEC27nPJT3NoJSNf1FxenvKRGizLWks5XrijcwA%3D%3D | bash

cd /etc
# tar -czf /home/pi/authfiles.tgz passwd group shadow gshadow sudoers systemd/system/autologin@.service
sed -i.$(date +'%y%m%d_%H%M%S') 's/\bpi\b/moodlebox/g' passwd group shadow gshadow sudoers systemd/system/autologin@.service
mv /home/pi /home/moodlebox
# rm authfiles.tgz

# ### Following steps: main part

## Remove logging to /dev/xconsole from the default rsyslog configuration
# https://anonscm.debian.org/cgit/collab-maint/rsyslog.git/commit/?id=67bc8e5326b0d3564c7e2153dede25f9690e6839
sed -i '/# The named pipe \/dev\/xconsole/,$d' /etc/rsyslog.conf
service rsyslog restart

## Some bash configurations
cat << "EOF" >> /home/moodlebox/.bashrc

alias ll='ls -la'

# Assign arrow keys to history search in bash
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
# TAB cycles through the list of partial matches
bind 'TAB:menu-complete'
EOF

## Install all packages needed for the whole process
apt-get install -y hostapd dnsmasq nginx php5-fpm php5-cli php5-xmlrpc php5-curl php5-gd php5-intl mysql-server php5-mysql git usbmount incron
echo root >> /etc/incron.allow
apt-get install -y phpmyadmin

## Access point and network configuration: edit configuration files
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

## Advertise mDNS services
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
mysql -u root -pMoodlebox4$ -t <<STOP
create database moodle;
grant all on moodle.* to 'root'@'localhost' identified by 'Moodlebox4$';
\q
STOP

sed -i '/table_cache/c\table_cache             = 512' /etc/mysql/my.cnf
sed -i '/table_cache/i table_definition_cache  = 512' /etc/mysql/my.cnf
sed -i '/max_connections/c\max_connections         = 100' /etc/mysql/my.cnf
sed -i '/query_cache_size/c\query_cache_size        = 8M' /etc/mysql/my.cnf
sed -i '/query_cache_size/i query_cache_type        = 0' /etc/mysql/my.cnf

## Download Moodle via git and create all needed directories, with adequate permissions
cd /var/www/
git clone git://git.moodle.org/moodle.git
cd moodle
git checkout MOODLE_31_STABLE
cd ..
rm -r html
mv moodle html
chown -R www-data:www-data html
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
/usr/bin/php "/var/www/html/admin/cli/install.php" \
  --lang=fr \
  --wwwroot="http://moodlebox.local" \
  --dataroot="/var/www/moodledata" \
  --dbname="moodle" \
  --prefix="mdl_" \
  --dbuser="root" \
  --dbpass="Moodlebox4$" \
  --fullname="MoodleBox" \
  --shortname="MoodleBox" \
  --adminuser=admin \
  --adminpass="Moodlebox4$" \
  --non-interactive \
  --agree-license
sed -i "/$CFG->directorypermissions/i \$CFG->xsendfile = 'X-Accel-Redirect';\n\$CFG->xsendfilealiases = array ('/dataroot/' => \$CFG->dataroot);\n" /var/www/html/config.php
chown www-data:www-data /var/www/html/config.php
/usr/bin/php /var/www/html/admin/cli/mysql_compressed_rows.php -f

## Install MoodleBox Admin Moodle plugin
cd /var/www/html/local
git clone https://github.com/martignoni/moodlebox.git
cd /var/www/html/local/moodlebox
touch .reboot-server; touch .shutdown-server; touch .set-server-datetime
chown -R www-data:www-data /var/www/html/local/moodlebox

/usr/bin/php "/var/www/html/admin/cli/upgrade.php" --non-interactive

## Configure incron jobs (for restart/shutdown from web interface)
(incrontab -l -u root 2>/dev/null; echo "/var/www/html/local/moodlebox/.reboot-server IN_CLOSE_WRITE /sbin/shutdown -r now") | incrontab -
(incrontab -l -u root 2>/dev/null; echo "/var/www/html/local/moodlebox/.shutdown-server IN_CLOSE_WRITE /sbin/shutdown -h now") | incrontab -
(incrontab -l -u root 2>/dev/null; echo "/var/www/html/local/moodlebox/.set-server-datetime IN_MODIFY /bin/bash /var/www/html/local/moodlebox/.set-server-datetime") | incrontab -

## Configure cron jobs
(crontab -l -u root 2>/dev/null; echo "*/3 * * * * nice -n 10 ionice -c2 /usr/bin/php /var/www/html/admin/cli/cron.php") | crontab -
(crontab -l -u root 2>/dev/null; echo "*/20 * * * * rsync -a --delete /var/cache/moodle/ /var/cache/moodle-cache-backup/") | crontab -
(crontab -l -u root 2>/dev/null; echo "@reboot cp -Rpf /var/cache/moodle-cache-backup/* /var/cache/moodle/") | crontab -

## Cleanup and shutdown
rm -r /var/www/moodledata/cache/*
rm -r /var/www/moodledata/localcache/*
rm -r /var/www/moodledata/temp/*
rm -r /var/www/moodledata/trashdir/*
rm -r /var/www/moodledata/sessions/*
rm -r /var/cache/moodle/*
rm -r /var/cache/moodle-cache-backup/*
mysql -u root -p'Moodlebox4$' moodle -e "truncate table moodle.mdl_logstore_standard_log"
mysql -u root -p'Moodlebox4$' moodle -e "truncate table moodle.mdl_config_log"
apt-get clean
rm -r /var/cache/debconf/*
rm -r /tmp/*
rm -r /var/tmp/*
rm ~/.mysql_history
rm ~/.nano_history
sudo bash -c 'for logs in `find /var/log -type f`; do > $logs; done'
cat /dev/null > ~/.bash_history && history -c && sudo shutdown -h now

## End