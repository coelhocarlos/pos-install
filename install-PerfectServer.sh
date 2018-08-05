#!/bin/bash
## Install ISPConfig3 on Ubuntu 16.04 64Bits
## Author: arlos Coelho
#Date - 06/22/2018
#Created by C
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



## Set lang en_US UTF8
## echo 'LC_ALL="en_US.utf8"' >>/etc/environment

# Check if user has root privileges
if [[ $EUID -ne 0 ]]; then
echo "You must run the script as root or using sudo"
   exit 1
fi


## Reconfigure Dash
echo "dash dash/sh boolean false" | debconf-set-selections
dpkg-reconfigure -f noninteractive dash > /dev/null 2>&1

MY_IP=$(ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}' | tr '\n' ' ')

echo -e "Set Server Name Ex: mail.seudominio.com.br : \c "
read  SERVER_FQDN

echo -e "Set Server IP Ex: $MY_IP : \c "
read  SERVER_IP

echo "" >>/etc/hosts
echo "$SERVER_IP  $SERVER_FQDN" >>/etc/hosts
hostnamectl set-hostname $SERVER_FQDN
echo "$SERVER_FQDN" > /proc/sys/kernel/hostname


## Stop and remove Apparmor, Sendmail
service apparmor stop
update-rc.d -f apparmor remove
apt-get remove -y apparmor apparmor-utils
service sendmail stop; update-rc.d -f sendmail remove

## Install VIM-NOX, SSH Server, Sudo, NTP
apt-get install -y ssh openssh-server sudo ntp ntpdate
service sendmail stop; update-rc.d -f sendmail remove

## Install Softwares Mail Server
apt-get install -y postfix postfix-mysql mariadb-client mariadb-server
apt-get install -y openssl getmail4 binutils
apt-get install -y dovecot-pop3d dovecot-mysql dovecot-sieve dovecot-lmtpd dovecot-imapd
apt-get install -y amavisd-new spamassassin zoo libnet-ldap-perl
apt-get install -y clamav clamav-base clamav-daemon clamav-freshclam
apt-get install -y unzip bzip2 arj nomarch lzop cabextract apt-listchanges
apt-get install -y libauthen-sasl-perl daemon libio-string-perl libjson-perl
apt-get install -y libio-socket-ssl-perl libnet-ident-perl zip libnet-dns-perl postgrey

## Stop Spamassassin
service spamassassin stop
update-rc.d -f spamassassin remove
## freshclam -v

sed -i 's|AllowSupplementaryGroups false|AllowSupplementaryGroups true|' /etc/clamav/clamd.conf
freshclam
service clamav-daemon start


sed -i 's|bind-address|#bind-address|' /etc/mysql/mariadb.conf.d/50-server.cnf

## Backup Postfix
mkdir -p /etc/postfix/backup
cp -aR /etc/postfix/* /etc/postfix/backup/

## Config Postfix /etc/postfix/master.cf
sed -i 's|#submission|submission|' /etc/postfix/master.cf
sed -i 's|#  -o syslog_name=postfix/submission|  -o syslog_name=postfix/submission|' /etc/postfix/master.cf
sed -i 's|#  -o smtpd_tls_security_level=encrypt|  -o smtpd_tls_security_level=may|' /etc/postfix/master.cf
sed -i 's|#  -o smtpd_sasl_auth_enable=yes|  -o smtpd_sasl_auth_enable=yes|' /etc/postfix/master.cf
sed -i 's|#  -o smtpd_reject_unlisted_recipient=no|  -o smtpd_client_restrictions=permit_sasl_authenticated,reject|' /etc/postfix/master.cf

sed -i 's|#smtps|smtps|' /etc/postfix/master.cf
sed -i 's|#  -o syslog_name=postfix/smtps|  -o syslog_name=postfix/smtps|' /etc/postfix/master.cf
sed -i 's|#  -o smtpd_tls_wrappermode=yes|  -o smtpd_tls_wrappermode=yes|' /etc/postfix/master.cf
sed -i 's|#  -o smtpd_sasl_auth_enable=yes|  -o smtpd_sasl_auth_enable=yes|' /etc/postfix/master.cf
sed -i 's|#  -o smtpd_reject_unlisted_recipient=no|  -o smtpd_client_restrictions=permit_sasl_authenticated,reject|' /etc/postfix/master.cf

## Restart Postfix and Mysql
service postfix restart

mysql_secure_installation
service mysql restart

## Install Softwares Web Server

apt-get install -y apache2 apache2-doc apache2-utils libapache2-mod-php php7.0 php7.0-common 
apt-get install -y php7.0-gd php7.0-mysql php7.0-imap php7.0-cli php7.0-cgi libapache2-mod-fcgid 
apt-get install -y apache2-suexec-pristine php-pear php-auth php7.0-mcrypt mcrypt  imagemagick libruby 
apt-get install -y libapache2-mod-python php7.0-curl php7.0-intl php7.0-pspell php7.0-recode php-net-sieve tinymce
apt-get install -y php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-opcache php-apcu libapache2-mod-fastcgi php7.0-fpm
apt-get install -y php7.0-xsl memcached php-memcache php-imagick php-gettext php7.0-zip php7.0-mbstring

echo "<IfModule mod_headers.c>
    RequestHeader unset Proxy early
</IfModule>" | tee /etc/apache2/conf-available/httpoxy.conf


## Enable Softwares PHP and Apache2 modules
a2enmod suexec rewrite ssl actions include cgi
a2enmod dav_fs dav auth_digest headers actions fastcgi alias
a2enconf httpoxy

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
add-apt-repository "deb http://dl.hhvm.com/ubuntu xenial main"
apt-get update && apt-get install -y hhvm
echo 'hhvm.mysql.socket = /var/run/mysqld/mysqld.sock' >> /etc/hhvm/php.ini

service apache2 restart

## Install Let's Encrypt | apt-get install -y certbot
mkdir /opt/certbot
cd /opt/certbot
wget https://dl.eff.org/certbot-auto
chmod a+x ./certbot-auto && ./certbot-auto

 
## Install Softwares FTP Server
apt-get install -y pure-ftpd-common pure-ftpd-mysql quota quotatool libclass-dbi-mysql-perl
apt-get install -y bind9 dnsutils vlogger webalizer awstats geoip-database haveged ufw
apt-get install -y build-essential autoconf automake1.9 libtool flex bison debhelper binutils-gold

rm -f /etc/cron.d/awstats
sed -i 's|VIRTUALCHROOT=false|VIRTUALCHROOT=true|' /etc/default/pure-ftpd-common
sed -i 's|application/x-ruby|#application/x-ruby|' /etc/mime.types

## echo 1 > /etc/pure-ftpd/conf/TLS
mkdir -p /etc/ssl/private/
openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
chmod 600 /etc/ssl/private/pure-ftpd.pem
service pure-ftpd-mysql restart


## Adicionando o Quota de forma automatica
#sed -i 's|defaults|defaults,usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0|' /etc/fstab
#mount -o remount /var/www
#quotacheck -avugm
#quotaon -avug

## Download ISPConfig 3.1.X
cd /tmp
get_isp=https://www.ispconfig.org/downloads/ISPConfig-3-stable.tar.gz
wget -c ${get_isp}
tar xvfz $(basename ${get_isp})
cd ispconfig3_install/install && php -q install.php

## Install PHPMyadmin
## Para Instalar o PHPMyadmin Execute o Script abaixo
## https://gist.github.com/jniltinho/9af397c8ddb035a322b75aecce7cdeae
################################################################################
#                               FINISH                                         #
################################################################################
echo -e  ${WHITE}
sudo apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade








