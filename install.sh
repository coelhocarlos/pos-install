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
#WHITE=`tput setaf 7`

BOLD=`tput bold`
RESET=`tput sgr0`
#tput setab 7

################################################################################
#                               Start Script                                   #
################################################################################

echo -e  ${WHITE}
echo -e  ${YELLOW}
cat /etc/*-release
echo -e  ${RED}
#sudo nano /etc/netplan/
#sudo netplan apply
echo -e  ${WHITE} 
echo -e " ${BLUE} CHECK UPDATES ..."
echo -e  ${WHITE} 
sudo apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade

################################################################################
#                                   UTEIS                                      #
################################################################################

echo -e "${BLUE} LIBRARIES INSTALL"
echo -e  ${WHITE}
   sudo apt install -y  wget
   sudo apt install -y  gcc wget
   sudo apt install -y  git wget
   sudo apt install -y  make wget
   sudo apt install -y  ntfs-3g wget
   sudo apt install -y  testdisk wget
   sudo apt install -y  iptraf wget
   sudo apt install -y  genisoimage wget
   sudo apt install -y  wimtools -wget
   sudo apt install -y  cabextract -wget
ln -s /usr/bin/genisoimage /usr/bin/mkisofs
echo -e ${CYAN}"LIBRARIES INSTALLED --${GREEN} Successfull"

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

################################################################################
#                                   PHP                                        #
################################################################################

echo -e "${YELLOW} PHP 7.2 INSTALL"
echo -e  ${WHITE} 
    sudo apt install -y php7.2 libapache2-mod-php7.2 wget
    sudo apt-get -y install php7.2-mysql php7.2-curl php7.2-gd php7.2-intl php-pear php-imagick php7.2-imap php-memcache  php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-mbstring php-gettext || local ERROR=1
    sudo systemctl restart apache2 
    sudo apt-get -y install php7.2-opcache php-apcu
    sudo systemctl restart apache2 
    sudo a2enmod ssl 
    sudo systemctl restart apache2
    sudo a2ensite default-ssl
    sudo systemctl restart apache2
echo -e "${CYAN} PHP 7.2 INSTALLED ${GREEN}Successfull"

################################################################################
#                                   Apache SSL                                 #
################################################################################

echo -e "${YELLOW} APACHE INSTALL"
echo -e ${WHITE}
    sudo apt install -y apache2 apache2-utils libapache2-mod-php wget
   
    sudo a2enmod auth_digest ssl reqtimeout
    #sudo ufw app list 
    
    echo "Timeout 30" >> /etc/apache2/apache2.conf
    echo "ServerSignature Off" >> /etc/apache2/apache2.conf
    echo "ServerTokens Prod" >> /etc/apache2/apache2.conf
    
    sudo mkdir -p /var/www/server 
    sudo mkdir -p /var/www/public
    
    sudo chown -R www-data:www-data
    sudo chown -R $zombie:$zombie /var/www/html 
    sudo chown -R $zombie:$zombie /var/www/server 
    sudo chown -R $zombie:$zombie /var/www/public 

    sudo chmod -R 755 /var/www/html
    sudo chmod -R 755 /var/www/public
    sudo chmod -R 755 /var/www/server
    
    sudo systemctl restart apache2
    sudo mkdir /etc/apache2/ssl
    sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.pem -out /etc/apache2/ssl/apache.pem
    sudo chmod 600 /etc/apache2/ssl/apache.pem
    #------------------------------------80------------------------------------------------------------------------
    echo "<VirtualHost *:80>" >> /etc/apache2/sites-available/default
    echo "ServerAdmin webmaster@localhost" >> /etc/apache2/sites-available/default

    echo "DocumentRoot /var/www/html" >> /etc/apache2/sites-available/default
    echo "<Directory />" >> /etc/apache2/sites-available/default
    echo "Options FollowSymLinks" >> /etc/apache2/sites-available/default
    echo "AllowOverride All" >> /etc/apache2/sites-available/default
    echo "</Directory>" >> /etc/apache2/sites-available/default
    echo "<Directory /var/www/html/>" >> /etc/apache2/sites-available/default
    echo "Options -Indexes FollowSymLinks MultiViews" >> /etc/apache2/sites-available/default
    echo "AllowOverride None" >> /etc/apache2/sites-available/default
    echo "Order allow,deny" >> /etc/apache2/sites-available/default
    echo "allow from all" >> /etc/apache2/sites-available/default
    echo "</Directory>" >> /etc/apache2/sites-available/default

    echo "ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/" >> /etc/apache2/sites-available/default
    echo "<Directory "/usr/lib/cgi-bin">" >> /etc/apache2/sites-available/default
    echo "AllowOverride None" >> /etc/apache2/sites-available/default
    echo "Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch" >> /etc/apache2/sites-available/default
    echo "Order allow,deny" >> /etc/apache2/sites-available/default
    echo "Allow from all" >> /etc/apache2/sites-available/default
    echo "</Directory>" >> /etc/apache2/sites-available/default

    erro "ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/default

    echo "# Possible values include: debug, info, notice, warn, error, crit, alert, emerg." >> /etc/apache2/sites-available/default
    echo "LogLevel warn" >> /etc/apache2/sites-available/default

    echo "CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/default
    #--------------------------------------443----------------------------------------------------------------------
    echo "<VirtualHost *:443>" >> /etc/php7.2/apache2/php.ini
    echo "ServerAdmin webmaster@localhost" >> /etc/php7.2/apache2/php.ini
    echo "ServerName <server.address>:443" >> /etc/php7.2/apache2/php.ini

    echo "SSLEngine on" >> /etc/php5/apache2/php.ini
    echo "SSLCertificateFile /etc/apache2/ssl/apache.pem" >> /etc/php7.2/apache2/php.ini

    echo "DocumentRoot /var/www/html/"  >> /etc/php7.2/apache2/php.ini
    echo "<Directory />" >> /etc/php7.2/apache2/php.ini
    echo "Options FollowSymLinks" >> /etc/php7.2/apache2/php.ini
    echo "AllowOverride All" >> /etc/php7.2/apache2/php.ini
    echo "</Directory>" >> /etc/php7.2/apache2/php.ini
    echo "<Directory /var/www/html/>" >> /etc/php7.2/apache2/php.ini
    echo "Options -Indexes FollowSymLinks MultiViews" >> /etc/php7.2/apache2/php.ini
    echo "AllowOverride None" >> /etc/php7.2/apache2/php.ini
    echo "Order allow,deny" >> /etc/php7.2/apache2/php.ini
    echo "allow from all" >> /etc/php7.2/apache2/php.ini
    echo "</Directory>"  >> /etc/php7.2/apache2/php.ini

    echo "ErrorLog ${APACHE_LOG_DIR}/error.log"

    echo "# Possible values include: debug, info, notice, warn, error, crit, alert, emerg."
    echo "LogLevel warn"

    echo "CustomLog ${APACHE_LOG_DIR}/access.log combined"
    
    echo "NameVirtualHost *:80" >> /etc/apache2/ports.conf
    echo "Listen 80" >> /etc/apache2/ports.conf
    echo "<IfModule mod_ssl.c>" >> /etc/apache2/ports.conf
    echo "NameVirtualHost *:443" >> /etc/apache2/ports.conf
    echo "Listen 443" >> /etc/apache2/ports.conf
    echo "</IfModule>" >> /etc/apache2/ports.conf
    echo "<IfModule mod_gnutls.c>" >> /etc/apache2/ports.conf
    echo "Listen 443" >> /etc/apache2/ports.conf
    echo "</IfModule>" >> /etc/apache2/ports.conf
    sudo a2ensite default-ssl
    sudo systemctl restart apache2
    
    # PHP INI 
    echo "upload_max_filesize = 64M" >> /etc/php7.2/apache2/php.ini
    echo "max_file_uploads = 200" >> /etc/php7.2/apache2/php.ini
    echo "post_max_size = 128M" >> /etc/php7.2/apache2/php.ini
    sudo systemctl restart apache2
    
   
    #sudo ufw status
    #sudo systemctl status apache2
echo -e " ${CYAN} APACHE INSTALLED ${GREEN}Successfull"
################################################################################
#                                   MYSQL                                      #
################################################################################

echo -e  "${YELLOW} MYSQL INSTALL"
echo -e  ${WHITE}
    sudo apt install -y mysql-server wget
    sudo apt install -y mysql-client wget
    #sudo mysql_secure_installation
    sudo systemctl restart mysql.service
echo -e "${CYAN} MYSQL INSTALLED ${GREEN}Successfull"

################################################################################
#                                   SAMBA                                      #
################################################################################

echo -e  "${YELLOW} SAMBA INSTALL"
echo -e  ${WHITE}
        sudo apt install -y samba wget 
        sudo cp /etc/samba/smb.conf /etc/samba/smb.conf_backup
        touch /etc/samba/smb.conf
    
        sudo echo  "[wds_share]" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/wds_share" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf

        sudo echo "[imagens]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Imagens" >> /etc/samba/smb.conf
	
        sudo echo "[media]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Media" >> /etc/samba/smb.conf

        sudo echo "[manutencao]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Manutencao" >> /etc/samba/smb.conf
	
        sudo echo "[www]" >> /etc/samba/smb.conf
	sudo echo "valid users = zombie" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /var/www" >> /etc/samba/smb.conf

        sudo echo "[programacao]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "valid users = zombie" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Programacao" >> /etc/samba/smb.conf

        sudo echo "[clients]" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/Clientes" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "valid users = zombie" >> /etc/samba/smb.conf
	
	sudo echo "[push]" >> /etc/samba/smb.conf
	sudo echo "path = /media/hd2000/torrent/torrent-push" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo service smbd restart
        #sudo bash -c 'grep -v -E "^#|^;" /etc/samba/smb.conf_backup | grep . > /etc/samba/smb.conf'
echo -e "${CYAN} SAMBA INSTALLED ${GREEN}Successfull"

################################################################################
#                                   PHPMYADMIN                                 #
################################################################################

echo -e  "${YELLOW} PHPMYADMIN INSTALL"
echo -e  ${WHITE} 
    sudo apt install -y phpmyadmin php-gettext wget
echo -e "${CYAN} PHPMYADMIN INSTALLED ${GREEN}Successfull"

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
echo -e "${CYAN} UTORRENT INSTALLED ${GREEN}Successfull"  

################################################################################
#                                   PXE                                        #
################################################################################

echo -e "${YELLOW} PXE INSTALL"
echo -e ${WHITE}
sudo apt install -y tftpd-hpa wget
    sudo echo "TFTP_DIRECTORY= /media/hd2000/wds_share" >> /etc/default/tftpd-hpa
    sudo echo "RUN_DAEMON="no"" >> /etc/default/tftpd-hpa
    sudo echo "OPTIONS="-l -s /media/hd2000/wds_share"" >> /etc/default/tftpd-hpa
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
    sudo service isc-dhcp-server restart
    sudo /etc/init.d/tftpd-hpa restart
echo -e "${CYAN} PXE INSTALLED ${GREEN} Successfull" 

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
echo -e "${CYAN} KMS SERVER INSTALLED ${GREEN}Successfull" 
cd
################################################################################
#                        PLEX MEDIA SERVER                                     #
################################################################################
 echo -e  "${YELLOW PLEX MEDIA SERVER INSTALL"
    echo -e  ${WHITE}
    wget https://downloads.plex.tv/plex-media-server/1.13.4.5251-2e6e8f841/plexmediaserver_1.13.4.5251-2e6e8f841_amd64.deb
    dpkg -i plexmediaserver_1.13.2.5154-fd05be322_amd64.deb
echo -e "${CYAN} PLEX MEDIA SERVER  INSTALLED ${GREEN}Successfull" 
################################################################################
#                           MEGA UPLOADER                                      #
################################################################################
 echo -e "${YELLOW} MEGATOOLS INSTALL"
    echo -e  "${WHITE}"
    cd
    sudo apt install megatools wget
    sudo touch ~/.megarc
    echo "[Login]" >> ~/.megarc
    echo "Username = carloscoelho_@live.com " >> ~/.megarc
    echo "Password = " >> ~/.megarc
 echo -e "${CYAN} MEGATOOLS  INSTALLED ${GREEN}Successfull"   
################################################################################
#                           SCRIPTS                                            #
################################################################################
 echo -e "${YELLOW} ADDING SCRIPTS"
  echo -e  ${WHITE}
cd
mkdir ~/.scripts
cd ~/.scripts
wget https://raw.githubusercontent.com/coelhocarlos/meganz/master/megasend.sh
wget https://raw.githubusercontent.com/coelhocarlos/sqldump/master/MysqlDump.sh
wget https://raw.githubusercontent.com/coelhocarlos/DebianScripts/master/duck.sh
chmod +x megasend.sh
chmod +x MysqlDump.sh
chmod +x duck.sh
echo "* 23 * * * ~/.scripts/mysqldump.sh #Mysql backup" >>/var/spool/cron/crontabs/root
echo "@daily ~/.scripts/megasend.sh" >> /var/spool/cron/crontabs/root
echo "5 * * * * ~/.scripts/duck.sh" >> /var/spool/cron/crontabs/root
 echo -e "${CYAN} SCRIPTS ADDED ${GREEN}Successfull" 
################################################################################
#                                MINECRAFT                                     #
################################################################################
echo -e "${YELLOW} INSTALL MINECRAFT"
    echo -e  ${WHITE}
sudo apt update
sudo apt install wget screen default-jdk nmap
sudo useradd -m -r -d /hd2000/Game-Serverss/minecraft minecraft
sudo mkdir /hd2000/Game-Serverss/minecraft/survival
sudo wget -O /hd2000/Game-Serverss/minecraft/survival/minecraft_server.jar https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar
sudo bash -c "echo eula=true > /hd2000/Game-Servers/minecraft/survival/eula.txt"
sudo chown -R minecraft /hd2000/Game-Servers/minecraft/survival/
echo "[Unit]" >> /etc/systemd/system/minecraft@.service
echo "Description=Minecraft Server: %i" >> /etc/systemd/system/minecraft@.service
echo "After=network.target" >> /etc/systemd/system/minecraft@.service

echo "[Service]" >> /etc/systemd/system/minecraft@.service
echo "WorkingDirectory=/opt/minecraft/%i" >> /etc/systemd/system/minecraft@.service

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

echo -e "{$RED}for execute minecraft server use"
echo -e "{$BLUE}sudo systemctl start minecraft@survival"
echo -e "{$RED}for confirm status"
echo -e "{$BLUE}sudo systemctl status minecraft@survival"
echo -e "{$RED}for execute auto start on boot"
echo -e "{$BLUE}sudo systemctl enable minecraft@survival"
echo -e "{$RED}check minecraft port"
echo -e "{$BLUE}nmap -p 25565 localhost"
echo -e {$WRITE}

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
    sudo ufw allow samba
    sudo ufw allow Php
    sudo ufw allow 32400
    sudo ufw allow 27015
    sudo ufw allow 27018
    sudo ufw allow 25565
    sudo ufw allow 25567
    sudo ufw allow 1688
    echo -e  ${RED} 
    sudo ufw enable 
    echo -e  ${WHITE}
echo -e ${CYAN}"UFW SET   ${GREEN}ADDED Successful"
################################################################################
#                               FINISH                                         #
################################################################################
echo -e  ${WHITE}
sudo apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade
echo -e ${YELLOW}
echo -e  ${WHITE}
echo "shutdown server ?"
echo -e ${YELLOW}
read -r -p "Are you sure? [Y/n]" response
 response=${response,,} # tolower
 if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    shutdown -r 0
 fi
################################################################################
#                               CHECK PACKAGES                                 #
################################################################################
tput bel
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' plex|grep "install ok installed")
echo -e  Checking for ${BOLD}apache2${WHITE}:  ${GREEN}OK!  "\xE2\x9C\x94" ${WHITE}
if [ "" == "$PKG_OK" ]; then
echo -e  "${RED}apache2 ${YELLOW} Not Installed ${RED}error \u274c\n  ${YELLOW} ${WHITE}"
sudo apt install apache2 wget
fi
declare -a packages=("webmin" "apache2" "php7.2" "plex" "utorrent" "megatools");

for i in "${packages[@]}"; do
    if [ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo -e "$i Not Installed ${RED}error \u274c\n   ${WHITE}";
        echo "$i is not installed, would you like to install it now? (Y/N)";
        read response
        if [ "$response" == "y" ] || [ "$response" == "Y" ]; then
            sudo apt-get install "$i";
        else
            echo "Skipping the installation of $i...";
        fi
    else
        echo -e  "The $i package has already been installed.  ${GREEN} OK! \xE2\x9C\x94  ${WHITE}";
    fi
done






