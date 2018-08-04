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
#                               Start Script                                   #
################################################################################

tput setab 7
echo -e  ${YELLOW} 
echo -e " ${RED} CHECK UPDATES ..."
echo -e  ${BLACK} 
sudo apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade
echo -e  ${WHITE}
tput reset
################################################################################
#                                 LIBRARIES INSTALL                            #
################################################################################

echo -e "${RED} LIBRARIES INSTALL"
echo -e  ${WHITE}
   sudo apt install -y  wget
   sudo apt install -y  gcc wget
   sudo apt install -y  git wget
   sudo apt install -y  make wget
   sudo apt install -y  touch wget
   sudo apt install -y  ntfs-3g wget
   sudo apt install -y  testdisk wget
   sudo apt install -y  glances wget
   sudo apt install -y  iptraf wget
   sudo apt install -y  genisoimage wget
   sudo apt install -y  wimtools -wget
   sudo apt install -y  cabextract -wget
ln -s /usr/bin/genisoimage /usr/bin/mkisof
echo -e ${CYAN}"LIBRARIES INSTALLED --${GREEN} Successfull"
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                         MOUNT HD EXTERN                                      #
################################################################################
echo -e "${RED} MOUNT HD EXTERN"
echo -e  ${WHITE}

mkdir /media/hd2000
#mount -t ntfs-3g /dev/sdb1 /media/hd160
mount -t ntfs-3g /dev/sdb1 /media/hd2000
echo -e ${CYAN}"MOUNTED AS /media/hd2000 --${GREEN} Successfull"
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                           SCRIPTS                                            #
################################################################################
 echo -e "${YELLOW} ADDING SCRIPTS"
  echo -e  ${WHITE}
cd
mkdir ~/.scripts
cd ~/.scripts
sudo wget https://raw.githubusercontent.com/coelhocarlos/meganz/master/megasend.sh
sudo wget https://raw.githubusercontent.com/coelhocarlos/sqldump/master/mysqldump.sh
sudo wget https://raw.githubusercontent.com/coelhocarlos/DebianScripts/master/duck.sh
sudo chmod +x megasend.sh
sudo chmod +x MysqlDump.sh
sudo chmod +x duck.sh
sudo touch /var/spool/cron/crontabs/root
sudo echo "* 23 * * * ~/.scripts/mysqldump.sh #Mysql backup" >>/var/spool/cron/crontabs/root
sudo echo "@daily ~/.scripts/megasend.sh" >> /var/spool/cron/crontabs/root
sudo echo "5 * * * * ~/.scripts/duck.sh" >> /var/spool/cron/crontabs/root
 echo -e "${CYAN} SCRIPTS ADDED ${GREEN}Successfull" 
cd 
cd downloads/
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                                   USERS                                      #
################################################################################
echo -e  "${YELLOW} ADD USERS"
echo -e  ${WHITE}
sudo adduser pedro
sudo adduser andre
sudo usermod -aG sudo pedro
sudo usermod -aG sudo andre
echo -e " ${CYAN} users added${GREEN}Successfull"
################################################################################
#                           MEGA UPLOADER                                      #
################################################################################
 echo -e "${YELLOW} MEGATOOLS INSTALL"
    echo -e  "${WHITE}"
    sudo apt install megatools wget
    cd 
    sudo touch ~/.megarc
    echo "[Login]" >> ~/.megarc
    echo "Username = carloscoelho_@live.com" >> ~/.megarc
    echo "Password = " >> ~/.megarc
 echo -e "${CYAN} MEGATOOLS  INSTALLED ${GREEN}Successfull"   
 echo -e ""
echo -e ""
echo -e ""
################################################################################
#                        PLEX MEDIA SERVER                                     #
################################################################################
 echo -e  "${YELLOW} PLEX MEDIA SERVER INSTALL"
    echo -e  ${WHITE}
    cd downloads/
    wget https://downloads.plex.tv/plex-media-server/1.13.4.5251-2e6e8f841/plexmediaserver_1.13.4.5251-2e6e8f841_amd64.deb
    dpkg -i plexmediaserver_1.13.4.5251-2e6e8f841_amd64.deb
echo -e "${CYAN} PLEX MEDIA SERVER  INSTALLED ${GREEN}Successfull" 
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                                  Webmin                                      #
################################################################################

echo -e  "{$YELLOW} WEBMIN INSTALL"
echo -e  ${WHITE}
   wget -qO- http://www.webmin.com/jcameron-key.asc | sudo apt-key add
   sudo add-apt-repository "deb http://download.webmin.com/download/repository sarge contrib"
   sudo apt update
   sudo apt -y install webmin
echo -e ${CYAN}"WEBMIN   ${GREEN}INSTALLED Successful"
echo -e ""
echo -e ""
echo -e ""

################################################################################
#                                   SAMBA                                      #
################################################################################

echo -e  "${YELLOW} SAMBA INSTALL"
echo -e  ${WHITE}
        sudo apt install -y samba wget 
        #sudo cp /etc/samba/smb.conf /etc/samba/smb.conf_backup
        #touch /etc/samba/smb.conf
    
        sudo echo  "[wds_share]" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/wds_share" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
        sudo echo ""
        sudo echo "[imagens]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Imagens" >> /etc/samba/smb.conf
	sudo echo ""
        sudo echo "[media]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Media" >> /etc/samba/smb.conf
        sudo echo ""
        sudo echo "[manutencao]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Manutencao" >> /etc/samba/smb.conf
	sudo echo ""
        sudo echo "[www]" >> /etc/samba/smb.conf
	sudo echo "valid users = zombie" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /var/www" >> /etc/samba/smb.conf
        sudo echo ""
        sudo echo "[programacao]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "valid users = zombie" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Programacao" >> /etc/samba/smb.conf
        sudo echo ""
        sudo echo "[clients]" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Clientes" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "valid users = zombie" >> /etc/samba/smb.conf
	sudo echo ""
	sudo echo "[push]" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/torrent/torrent-push" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo ""
	sudo echo "[Game-Server]" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000//media/hd2000/Game-Servers" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo ""
	sudo echo "[wwww]" >> /etc/samba/smb.conf
	sudo echo "path = /var/www/" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "valid users = zombie" >> /etc/samba/smb.conf
	sudo echo ""
	sudo smbpasswd -a zombie
	sudo smbpasswd -a pedro
	sudo smbpasswd -a andre
	sudo service smbd restart
        #sudo bash -c 'grep -v -E "^#|^;" /etc/samba/smb.conf_backup | grep . > /etc/samba/smb.conf'
echo -e "${CYAN} SAMBA INSTALLED ${GREEN}Successfull"
echo -e ""
echo -e ""
echo -e ""

################################################################################
#                                   UTORRENT                                   #
################################################################################

echo -e "${YELLOW} UTORRENT INSTALL"
echo -e ${WHITE}
    sudo apt install -y libssl1.0.0 libssl-dev wget 
    sudo wget http://download-new.utorrent.com/endpoint/utserver/os/linux-x64-ubuntu-13-04/track/beta/ -O utserver.tar.gz 
    sudo tar -zxvf utserver.tar.gz -C /opt/ 
    sudo chmod 777 /opt/utorrent-server-alpha-v3_3/
    sudo ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver
    sudo wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/utorrent
    sudo chmod 755 utorrent
    sudo cp utorrent /etc/init.d/
    cd /etc/init.d/ 
    sudo update-rc.d utorrent defaults
    sudo service utorrent start 
    #systemctl status utorrent.service
    sudo service utorrent restart
    cd /downloads
echo -e "${CYAN} UTORRENT INSTALLED ${GREEN}Successfull"  
echo -e ""
echo -e ""
echo -e ""



################################################################################
#                                   PXE                                        #
################################################################################

echo -e "${YELLOW} PXE INSTALL"
echo -e ${WHITE}
sudo apt install -y tftpd-hpa wget
    sudo echo 'TFTP_DIRECTORY= "/media/hd2000/wds_share"' >> /etc/default/tftpd-hpa
    sudo echo 'RUN_DAEMON="no"' >> /etc/default/tftpd-hpa
    sudo echo 'OPTIONS="-l -s /media/hd2000/wds_share"' >> /etc/default/tftpd-hpa
    sudo /etc/init.d/tftpd-hpa restart
    sudo apt install -y isc-dhcp-server wget
    sudo echo "option domain-name "coreserver.duckdns.org";" >> /etc/dhcp/dhcpd.conf
    sudo echo "option domain-name-servers ns1.coreserver.duckdns.org, ns2.coreser.duckdns.org;" >> /etc/dhcp/dhcpd.conf
    sudo echo "ddns-update-style interim; authoritative; allow booting; allow bootp; " >> /etc/dhcp/dhcpd.conf
    sudo echo "subnet 192.168.0.0 netmask 255.255.255.0" >>  /etc/dhcp/dhcpd.conf
    sudo echo " {" >> /etc/dhcp/dhcpd.conf
    sudo echo "range 192.168.0.100 192.168.0.254;" >>  /etc/dhcp/dhcpd.conf
    sudo echo "filename "pxelinux.0";" >> /etc/dhcp/dhcpd.conf
    sudo echo "default-lease-time 86400;" >> /etc/dhcp/dhcpd.conf
    sudo echo "max-lease-time 604800;" >> /etc/dhcp/dhcpd.conf
    sudo echo "option subnet-mask 255.255.255.0;"  >> /etc/dhcp/dhcpd.conf
    sudo echo "option broadcast-address 192.168.0.255;" >> /etc/dhcp/dhcpd.conf
    sudo echo "option domain-name-servers 192.168.0.1;" >> /etc/dhcp/dhcpd.conf
    sudo echo "option routers 192.168.0.1;" >>  /etc/dhcp/dhcpd.conf
    sudo echo " }" >>  /etc/dhcp/dhcpd.conf
    #/etc/default/isc-dhcp-server
    
    sudo echo 'INTERFACESv4="ens130"' >> /etc/default/isc-dhcp-server
    sudo echo 'INTERFACESv6="ens130"' >> /etc/default/isc-dhcp-server
    sudo service isc-dhcp-server restart
    sudo /etc/init.d/tftpd-hpa restart
echo -e "${CYAN} PXE INSTALLED ${GREEN} Successfull" 
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                               KMS SERVER                                     #
################################################################################
    echo -e  "${YELLOW} KMS SERVER INSTALL"
    echo -e  ${WHITE} 
    cd /opt
    sudo git clone https://github.com/myanaloglife/py-kms.git
    sudo echo 'kms:x:501:65534::/nonexistent:/bin/false' >> /etc/passwd
    sudo echo 'kms:*:16342:0:99999:7:::' >> /etc/shadow
    sudo echo '[Unit]' > /etc/systemd/system/py-kms.service
    sudo echo 'Description=Python KMS Server' >> /etc/systemd/system/py-kms.service
    sudo echo >> /etc/systemd/system/py-kms.service
    sudo echo '[Service]' >> /etc/systemd/system/py-kms.service
    sudo echo 'ExecStart=/usr/bin/python /opt/py-kms/server.py' >> /etc/systemd/system/py-kms.service
    sudo echo 'User=kms' >> /etc/systemd/system/py-kms.service
    sudo echo 'Restart=always' >> /etc/systemd/system/py-kms.service
    sudo echo 'RestartSec=1' >> /etc/systemd/system/py-kms.service
    sudo echo >> /etc/systemd/system/py-kms.service
    sudo echo '[Install]' >> /etc/systemd/system/py-kms.service
    sudo echo 'WantedBy=multi-user.target' >> /etc/systemd/system/py-kms.service
    systemctl enable py-kms.service
    systemctl start py-kms.service
   cd
echo -e "${CYAN} KMS SERVER INSTALLED ${GREEN}Successfull" 
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                                  UFW                                         #
################################################################################
echo -e "$YELLOW} UFW SET"
echo -e ${WHITE}
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow 22/tcp
    sudo ufw allow 69
    sudo ufw allow in on ens130 to any port 69
    sudo ufw allow 80/tcp
    sudo ufw allow in on ens130 to any port 80
    sudo ufw allow 443/tcp
    sudo ufw allow in on ens130 to any port 443
    sudo ufw allow 2121/tcp
    sudo ufw allow in on ens130 to any port 2121
    sudo ufw allow 8080/tcp
    sudo ufw allow in on ens130 to any port 8080
    sudo ufw allow Apache
    sudo ufw allow webmin
    sudo ufw allow 11000
    sudo ufw allow samba
    sudo ufw allow 32400
    sudo ufw allow 27015
    sudo ufw allow 27018
    sudo ufw allow 25565
    sudo ufw allow 25567
    sudo ufw allow 1688
    sudo ufw allow 61208
    echo -e  ${RED} 
    sudo ufw enable 
    echo -e  ${WHITE}
echo -e ${CYAN}"UFW SET   ${GREEN}ADDED Successful"
echo -e ""
echo -e ""
echo -e ""

################################################################################
#                                MINECRAFT                                     #
################################################################################
echo -e "${YELLOW} INSTALL MINECRAFT"
    echo -e  ${WHITE}
sudo apt update
sudo apt install wget screen default-jdk nmap

sudo useradd -m -r -d /media/hd2000/Game-Servers/minecraft minecraft
cd /media/hd2000/Game-Servers/
sudo mkdir minecraft
sudo cd minecraft 
sudo mkdir survival
sudo wget -O /media/hd2000/Game-Servers/minecraft/survival/minecraft_server.jar https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar
sudo bash -c "echo eula=true > /media/hd2000/Game-Servers/minecraft/survival/eula.txt"
sudo chown -R minecraft /media/hd2000/Game-Servers/minecraft/survival/
echo "[Unit]" >> /etc/systemd/system/minecraft@.service
echo "Description=Minecraft Server: %i" >> /etc/systemd/system/minecraft@.service
echo "After=network.target" >> /etc/systemd/system/minecraft@.service

echo "[Service]" >> /etc/systemd/system/minecraft@.service
echo "WorkingDirectory= /media/hd2000/Game-Servers/minecraft/%i" >> /etc/systemd/system/minecraft@.service

echo "User=minecraft" >> /etc/systemd/system/minecraft@.service
echo "Group=minecraft" >> /etc/systemd/system/minecraft@.service
echo "Restart=always" >> /etc/systemd/system/minecraft@.service

#FROM:
#ExecStart=/usr/bin/screen -DmS mc-%i /usr/bin/java -Xmx2G -jar minecraft_server.jar nogui
#TO:
#ExecStart=/usr/bin/screen -DmS mc-%i /usr/bin/java -Xmx4G -jar minecraft_server.jar nogui

echo "ExecStart=/usr/bin/screen -DmS mc-%i /usr/bin/java -Xmx2G -jar minecraft_server.jar nogui" >> /etc/systemd/system/minecraft@.service

echo "ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "say SERVER SHUTTING DOWN IN 5 SECONDS. SAVING ALL MAPS..."\015'" >> /etc/systemd/system/minecraft@.service
echo "ExecStop=/bin/sleep 5"
echo "ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "save-all"\015'" >> /etc/systemd/system/minecraft@.service
echo "ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "stop"\015'" >> /etc/systemd/system/minecraft@.service

echo "[Install]"
echo "WantedBy=multi-user.target"

echo -e {$WRITE}
echo -e "*****************************************************"
echo -e {$WRITE}
echo -e "{$RED} for execute minecraft server use"
echo -e "{$BLUE} sudo systemctl start minecraft@survival"
echo -e "{$RED} for confirm status"
echo -e "{$BLUE} sudo systemctl status minecraft@survival"
echo -e "{$RED} for execute auto start on boot"
echo -e "{$BLUE} sudo systemctl enable minecraft@survival"
echo -e "{$RED} check minecraft port"
echo -e "{$BLUE} nmap -p 25565 localhost"
echo -e {$WRITE}
echo -e "*****************************************************"
echo -e {$WRITE}
#sudo systemctl status minecraft@survival
#sudo systemctl start minecraft@survival
#sudo systemctl status minecraft@survival

echo -e "{$YELLOW}Add server Porperties"
############################### setings minecraft ##########################################
echo -e {$WRITE}
echo "max-tick-time=60000" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "generator-settings=" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "allow-nether=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "force-gamemode=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "gamemode=0" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "enable-query=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "player-idle-timeout=0" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "difficulty=1" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "spawn-monsters=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "op-permission-level=4" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "pvp=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "snooper-enabled=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "level-type=DEFAULT" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "hardcore=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "enable-command-block=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "max-players=200" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "network-compression-threshold=256" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "resource-pack-sha1=" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "max-world-size=29999984" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "server-port=25565" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "server-ip=" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "spawn-npcs=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "allow-flight=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "level-name=world" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "view-distance=10" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "resource-pack=" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "spawn-animals=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "white-list=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "generate-structures=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "online-mode=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "max-build-height=256" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "level-seed=" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "prevent-proxy-connections=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "use-native-transport=true" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "motd=A Minecraft ZOmbie The Zer0 Server" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo "enable-rcon=false" >> /hd2000/Game-Servers/minecraft/survival/server.properties
echo -e "{$YELLOW}Add server Porperties Suscessfull"
echo -e {$WRITE}
echo -e "${CYAN} MINECRAFT INSTALLED ${GREEN}Successfull" 
echo -e ""
echo -e ""
echo -e ""

#sudo systemctl stop minecraft@survival
#sudo systemctl enable minecraft@survival
#sudo systemctl start minecraft@survival
#sudo systemctl status minecraft@survival
cd 
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






