#!/bin/bash
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
apt install -y  sudo wget
sudo apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade
sudo passwd root
cd
su -
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
   sudo apt install -y  wimtools wget
   sudo apt install -y  cabextract wget
   sudo apt install -y  ufw wget
   
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
cd tmp/
echo -e ""
echo -e ""
echo -e ""
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
#                                   USERS                                      #
################################################################################
echo -e  "${YELLOW} ADD USERS"
echo -e  ${WHITE}
sudo adduser minduim
sudo usermod -aG sudo minduim
echo -e " ${CYAN} users added${GREEN}Successfull"
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
	sudo smbpasswd -a minduim
  
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
#                                   PXE                                        #
################################################################################

echo -e "${YELLOW} PXE INSTALL"
echo -e ${WHITE}
# tftp PXE
     sudo apt-get install tftpd-hpa -y
#nano /etc/default/tftpd-hpa
     sudo cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.old
     sudo rm /etc/default/tftpd-hpa
     sudo cd /etc/default/
     sudo wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/tftpd-hpa
     sudo /etc/init.d/tftpd-hpa restart
cd 
     sudo apt-get install dnsmasq -y
     sudo cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old
     sudo rm /etc/dnsmasq.conf
cd /etc/
    sudo wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/dnsmasq.conf
    sudo /etc/init.d/dnsmasq restart
cd 
    sudo apt-get install isc-dhcp-server -y
    sudo cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.old
    sudo cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.old
    sudo rm /etc/dhcp/dhcpd.conf
    sudo rm /etc/default/isc-dhcp-server
    sudo cd /etc/default/
    sudo wget https://raw.githubusercontent.com/coelhocarlos/DebianScripts/master/isc-dhcp-server
cd
cd /etc/dhcp/
    sudo wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/dhcpd.conf
cd 
    sudo service isc-dhcp-server restart

    sudo cp /etc/network/interfaces /etc/network/interfaces.old
    sudo rm /etc/network/interfaces
cd /etc/network/
    sudo wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/interfaces
    sudo /etc/init.d/networking restart
    sudo /etc/init.d/tftpd-hpa restart
echo -e "${CYAN} PXE INSTALLED ${GREEN} Successfull" 
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
#sudo systemctl status minecraft@survival
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
#                               FINISH                                         #
################################################################################
