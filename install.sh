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
sudo chmod +x mysqldump.sh
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
#                                   PHP                                        #
################################################################################

echo -e "${YELLOW} PHP 7.2 INSTALL"
echo -e  ${WHITE} 
    sudo apt install -y php7.2 libapache2-mod-php7.2 wget
    sudo apt-get -y install php7.2-mysql php7.2-curl php-fpm php7.2-gd php7.2-intl php-pear php-imagick php7.2-imap php-memcache  php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-mbstring php-gettext
    sudo wget http://archive.ubuntu.com/ubuntu/pool/universe/x/xdebug/php-xdebug_2.6.0-0ubuntu1_amd64.deb
    sudo dpkg -i php-xdebug_2.6.0-0ubuntu1_amd64.deb
    sudo systemctl restart apache2 
    sudo apt-get -y install php7.2-opcache php-apcu
    sudo systemctl restart apache2 
    sudo a2enmod ssl 
    sudo systemctl restart apache2
    sudo a2ensite default-ssl
    sudo systemctl restart apache2
echo -e "${CYAN} PHP 7.2 INSTALLED ${GREEN}Successfull"
echo -e ""
echo -e ""
echo -e ""
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
    sudo chown -R zombie:zombie /var/www/html 
    sudo chown -R zombie:zombie /var/www/server 
    sudo chown -R zombie:zombie /var/www/public 

    sudo chmod -R 755 /var/www/html
    sudo chmod -R 755 /var/www/public
    sudo chmod -R 755 /var/www/server
    
    sudo systemctl restart apache2
    sudo mkdir /etc/apache2/ssl
    sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.pem -out /etc/apache2/ssl/apache.pem
    sudo chmod 600 /etc/apache2/ssl/apache.pem

    sudo a2ensite default-ssl
    sudo systemctl restart apache2

echo -e " ${CYAN} APACHE INSTALLED ${GREEN}Successfull"
echo -e ""
echo -e ""
echo -e ""
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
#                                   PHPMYADMIN                                 #
################################################################################

echo -e  "${YELLOW} PHPMYADMIN INSTALL"
echo -e  ${WHITE} 
    sudo apt install -y phpmyadmin php-gettext wget
echo -e "${CYAN} PHPMYADMIN INSTALLED ${GREEN}Successfull"
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
    sudo ufw allow 21/tcp
    sudo ufw allow in on ens130 to any port 21
    sudo ufw allow apache
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

sudo systemctl stop minecraft@survival
sudo systemctl enable minecraft@survival
sudo systemctl start minecraft@survival
sudo systemctl status minecraft@survival
cd 


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

echo -e  "${yellow}checking  packages installed ...${white}"
i=0; n=0; progs=(apache2 mysql phpmyadmin php7.2);
for p in "${progs[@]}"; do
    if hash "$p" &>/dev/null
    then
        echo -e "${green} $p $white} $i is installed ${green} \xE2\x9C\x94 ${wh$
        let c++
    else
        echo -e "${red} $p ${white} $i is not installed ${red} \u274c\n ${white$
        #sudo apt  install  $p wget
        let n++
     fi
 done
printf "%d of %d programs were installed.\n" "$i" "${#progs[@]}"
printf "%d of %d programs were missing\n" "$n" "${#progs[@]}"






