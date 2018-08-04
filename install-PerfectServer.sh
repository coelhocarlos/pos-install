#
#Date - 06/22/2018
#Created by Carlos Coelho
#Pos Install Ubuntu server 18.04
#
BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`
BOLD=`tput bold`
RESET=`tput sgr0`

#tput setab 7


################################################################################
#                            PERFECT SERVER                                    #
################################################################################
#In this tutorial, I use the hostname server1.example.com with the IP address 192.168.1.100 and the gateway 192.168.1.1  
#These settings might differ for you, so you have to replace them where appropriate.  
#Before proceeding further you need to have a basic minimal installation of Ubuntu 18.04 as explained in the tutorial.
sudo -s
#before you proceed.
dpkg-reconfigure dash
service apparmor stop
update-rc.d -f apparmor remove 
apt-get remove apparmor apparmor-utils
apt-get -y install ntp
service sendmail stop; update-rc.d -f sendmail remove
apt-get -y install postfix postfix-mysql postfix-doc mariadb-client mariadb-server openssl getmail4 rkhunter binutils dovecot-imapd dovecot-pop3d dovecot-mysql dovecot-sieve dovecot-lmtpd sudo
#You will be asked the following questions:
#General type of mail configuration: <-- Internet Site
#System mail name: <-- server1.example.com
nano /etc/postfix/master.cf
#[...]
#submission inet n       -       y       -       -       smtpd
#  -o syslog_name=postfix/submission <--  uncoment
#  -o smtpd_tls_security_level=encrypt <--  uncoment
#  -o smtpd_sasl_auth_enable=yes <--  uncoment
#  -o smtpd_client_restrictions=permit_sasl_authenticated,reject <--  uncoment
#-o smtpd_client_restrictions=permit_sasl_authenticated,reject <-- add line and uncoment
#  -o smtpd_reject_unlisted_recipient=no
#  -o smtpd_client_restrictions=$mua_client_restrictions
#  -o smtpd_helo_restrictions=$mua_helo_restrictions
#  -o smtpd_sender_restrictions=$mua_sender_restrictions
#  -o smtpd_recipient_restrictions=permit_sasl_authenticated,reject
#  -o milter_macro_daemon_name=ORIGINATING
smtps     inet  n       -       y       -       -       smtpd
# -o syslog_name=postfix/smtps  <--  uncoment
#  -o smtpd_tls_wrappermode=yes <--  uncoment
#  -o smtpd_sasl_auth_enable=yes <--  uncoment
#  -o smtpd_client_restrictions=permit_sasl_authenticated,reject <--  uncoment
#-o smtpd_client_restrictions=permit_sasl_authenticated,reject <-- add line and uncoment
#  -o smtpd_reject_unlisted_recipient=no
#  -o smtpd_client_restrictions=$mua_client_restrictions
#  -o smtpd_helo_restrictions=$mua_helo_restrictions
#  -o smtpd_sender_restrictions=$mua_sender_restrictions
#  -o smtpd_recipient_restrictions=permit_sasl_authenticated,reject
#  -o milter_macro_daemon_name=ORIGINATING
#[...]
service postfix restart
nano /etc/mysql/mariadb.conf.d/50-server.cnf
#[...]
# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
#bind-address           = 127.0.0.1  <--  coment
mysql_secure_installation
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
nano /etc/mysql/debian.cnf
service mysql restart
netstat -tap | grep mysql
#To install amavisd-new, SpamAssassin, and ClamAV, we run
apt-get -y install amavisd-new spamassassin clamav clamav-daemon unzip bzip2 arj nomarch lzop cabextract apt-listchanges libnet-ldap-perl libauthen-sasl-perl clamav-docs daemon libio-string-perl libio-socket-ssl-perl libnet-ident-perl zip libnet-dns-perl postgrey
service spamassassin stop
update-rc.d -f spamassassin remove
freshclam
service clamav-daemon start
cd /tmp
wget https://git.ispconfig.org/ispconfig/ispconfig3/raw/stable-3.1/helper_scripts/ubuntu-amavisd-new-2.11.patch
cd /usr/sbin
cp -pf amavisd-new amavisd-new_bak
patch < /tmp/ubuntu-amavisd-new-2.11.patch
apt-get -y install git lua5.1 liblua5.1-0-dev lua-filesystem libidn11-dev libssl-dev lua-zlib lua-expat lua-event lua-bitop lua-socket lua-sec luarocks luarocks
luarocks install lpc
adduser --no-create-home --disabled-login --gecos 'Metronome' metronome
cd /opt; git clone https://github.com/maranda/metronome.git metronome
cd ./metronome; ./configure --ostype=debian --prefix=/usr
make
make install
#Install Apache, PHP, phpMyAdmin, FCGI, SuExec, Pear, and mcrypt
apt-get -y install apache2 apache2-doc apache2-utils libapache2-mod-php php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-imap phpmyadmin php7.2-cli php7.2-cgi libapache2-mod-fcgid apache2-suexec-pristine php-pear mcrypt  imagemagick libruby libapache2-mod-python php7.2-curl php7.2-intl php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl memcached php-memcache php-imagick php-gettext php7.2-zip php7.2-mbstring php-soap php7.2-soap
a2enmod suexec rewrite ssl actions include cgi
a2enmod dav_fs dav auth_digest headers
nano /etc/apache2/conf-available/httpoxy.conf
#PASTE THIS CoNTENT
#<IfModule mod_headers.c>
#    RequestHeader unset Proxy early
#</IfModule>
a2enconf httpoxy
service apache2 restart
nano /etc/mime.types
#application/x-ruby                             rb <--  uncoment
service apache2 restart
apt-get -y install php7.2-opcache php-apcu
service apache2 restart
apt-get -y install php7.2-fpm
a2enmod actions proxy_fcgi alias 
service apache2 restart
apt-get -y install hhvm
apt-get -y install certbot
apt-get -y install mailman
newlist mailman
#root@server1:~# newlist mailman 
#Enter the email of the person running the list: <-- admin email address, e.g. listadmin@example.com 
#Initial mailman password: <-- admin password for the mailman list 
#To finish creating your mailing list, you must edit your /etc/aliases (or 
#equivalent) file by adding the following lines, and possibly running the 
#`newaliases' program: 

## mailman mailing list 
#mailman:              "|/var/lib/mailman/mail/mailman post mailman" 
#mailman-admin:        "|/var/lib/mailman/mail/mailman admin mailman" 
#mailman-bounces:      "|/var/lib/mailman/mail/mailman bounces mailman" 
#mailman-confirm:      "|/var/lib/mailman/mail/mailman confirm mailman" 
#mailman-join:         "|/var/lib/mailman/mail/mailman join mailman" 
#mailman-leave:        "|/var/lib/mailman/mail/mailman leave mailman" 
#mailman-owner:        "|/var/lib/mailman/mail/mailman owner mailman" 
#mailman-request:      "|/var/lib/mailman/mail/mailman request mailman" 
#mailman-subscribe:    "|/var/lib/mailman/mail/mailman subscribe mailman" 
#mailman-unsubscribe:  "|/var/lib/mailman/mail/mailman unsubscribe mailman" 
#Hit enter to notify mailman owner... <-- ENTER 
nano /etc/aliases
#... and add the following lines:
## mailman mailing list
#mailman:              "|/var/lib/mailman/mail/mailman post mailman"
#mailman-admin:        "|/var/lib/mailman/mail/mailman admin mailman"
#mailman-bounces:      "|/var/lib/mailman/mail/mailman bounces mailman"
#mailman-confirm:      "|/var/lib/mailman/mail/mailman confirm mailman"
#mailman-join:         "|/var/lib/mailman/mail/mailman join mailman"
#mailman-leave:        "|/var/lib/mailman/mail/mailman leave mailman"
#mailman-owner:        "|/var/lib/mailman/mail/mailman owner mailman"
#mailman-request:      "|/var/lib/mailman/mail/mailman request mailman"
#mailman-subscribe:    "|/var/lib/mailman/mail/mailman subscribe mailman"
#mailman-unsubscribe:  "|/var/lib/mailman/mail/mailman unsubscribe mailman"
newaliases
service postfix restart
ln -s /etc/mailman/apache.conf /etc/apache2/conf-available/mailman.conf
a2enconf mailman
service mailman start
#pureftpd
apt-get -y install pure-ftpd-common pure-ftpd-mysql quota quotatool
nano /etc/default/pure-ftpd-common
#STANDALONE_OR_INETD=standalone
#[...]
#VIRTUALCHROOT=true
#[...]
echo 1 > /etc/pure-ftpd/conf/TLS
mkdir -p /etc/ssl/private/
openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
chmod 600 /etc/ssl/private/pure-ftpd.pem
service pure-ftpd-mysql restart
nano /etc/fstab
#add lines
#/dev/mapper/server1--vg-root / ext4 errors=remount-ro,usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0 0 1
#/dev/mapper/server1--vg-swap_1 none swap sw 0 0
#/dev/fd0 /media/floppy0 auto rw,user,noauto,exec,utf8 0 0
mount -o remount /
quotacheck -avugm
quotaon -avug
apt-get -y install bind9 dnsutils haveged
systemctl enable haveged
systemctl start haveged
apt-get -y install vlogger webalizer awstats geoip-database libclass-dbi-mysql-perl
nano /etc/cron.d/awstats
#add lines
#MAILTO=root
#*/10 * * * * www-data [ -x /usr/share/awstats/tools/update.sh ] && /usr/share/awstats/tools/update.sh
# Generate static reports:
#10 03 * * * www-data [ -x /usr/share/awstats/tools/buildstatic.sh ] && /usr/share/awstats/tools/buildstatic.sh
apt-get -y install build-essential autoconf automake1.11 libtool flex bison debhelper binutils
cd /tmp 
wget http://olivier.sessink.nl/jailkit/jailkit-2.19.tar.gz
tar xvfz jailkit-2.19.tar.gz
cd jailkit-2.19
echo 5 > debian/compat
nano debian/changelog 
# And add the following line in line 5 plus an empty line afterward: -- Olivier <olivier@marshall>  Wed, 18 Nov 2015 20:38:44 +0100
./debian/rules binary
cd ..
dpkg -i jailkit_2.19-1_*.deb
rm -rf jailkit-2.19*
apt-get -y install fail2ban
nano /etc/fail2ban/jail.local
#add lines
#[pure-ftpd]
#enabled  = true
#port     = ftp
#filter   = pure-ftpd
#logpath  = /var/log/syslog
#maxretry = 3

#[dovecot]
#enabled = true
#filter = dovecot
#action = iptables-multiport[name=dovecot-pop3imap, port="pop3,pop3s,imap,imaps", protocol=tcp]
#logpath = /var/log/mail.log
#maxretry = 5

#[postfix]
#enabled  = true
#port     = smtp
#filter   = postfix
#logpath  = /var/log/mail.log
#maxretry = 3
service fail2ban restart
apt-get install ufw
#install roundcube
apt-get -y install roundcube roundcube-core roundcube-mysql roundcube-plugins javascript-common libjs-jquery-mousewheel php-net-sieve tinymce
nano /etc/apache2/conf-enabled/roundcube.conf
#and remove the # in front of the Alias line, then add the second Alias line for /webmail and add the line "AddType application/x-httpd-php .php" right after the "<Directory /var/lib/roundcube>" line:
#sample
# Those aliases do not work properly with several hosts on your apache server
# Uncomment them to use it or adapt them to your configuration
#Alias /roundcube /var/lib/roundcube <--  uncoment
#Alias /webmail /var/lib/roundcube <--  uncoment
#[...]
#<Directory /var/lib/roundcube> <--  uncoment
#AddType application/x-httpd-php .php <--  uncoment
#[...]
service apache2 restart
nano /etc/roundcube/config.inc.php
#change to $config['default_host'] = 'localhost';
#install ispconfig
cd /tmp 
wget -O ispconfig.tar.gz https://git.ispconfig.org/ispconfig/ispconfig3/repository/archive.tar.gz?ref=stable-3.1
tar xfz ispconfig.tar.gz
cd ispconfig3*/install/
php -q install.php
#Afterward you can access ISPConfig 3 under http(s)://server1.example.com:8080/ or http(s)://192.168.0.100:8080/ (HTTP or HTTPS depends on what you chose during installation). Log in with the username admin and the password admin (you should change the default password after your first login):
################################################################################
#                               FINISH                                         #
################################################################################
echo -e  ${WHITE}
sudo apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade








