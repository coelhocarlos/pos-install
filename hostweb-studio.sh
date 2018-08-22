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
apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade
echo -e  ${WHITE}
tput reset
################################################################################
#                                 LIBRARIES INSTALL                            #
################################################################################

echo -e "${RED} LIBRARIES INSTALL"
echo -e  ${WHITE}
   
    apt-update
    apt install -y  wget
    apt install -y  gcc wget
    apt install -y  git wget
    apt install -y  make wget
    apt install -y  touch wget
    apt install -y  ntfs-3g wget
    apt install -y  testdisk wget
    apt install -y  glances wget
    apt install -y  iptraf wget
    apt install -y  genisoimage wget
    apt install -y  wimtools wget
    apt install -y  cabextract wget
    apt install -y  ufw wget
    apt install -y firmware-linux-nonfree wget

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
 wget https://raw.githubusercontent.com/coelhocarlos/meganz/master/megasend.sh
 wget https://raw.githubusercontent.com/coelhocarlos/sqldump/master/mysqldump.sh
 wget https://raw.githubusercontent.com/coelhocarlos/DebianScripts/master/duck.sh
 chmod +x megasend.sh
 chmod +x mysqldump.sh
 chmod +x duck.sh
 touch /var/spool/cron/crontabs/root
 echo "* 23 * * * ~/.scripts/mysqldump.sh #Mysql backup" >>/var/spool/cron/crontabs/root
 echo "@daily ~/.scripts/megasend.sh" >> /var/spool/cron/crontabs/root
 echo "5 * * * * ~/.scripts/duck.sh" >> /var/spool/cron/crontabs/root
 echo -e "${CYAN} SCRIPTS ADDED ${GREEN}Successfull" 
cd 
cd /tmp
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                           MEGA UPLOADER                                      #
################################################################################
 echo -e "${YELLOW} MEGATOOLS INSTALL"
    echo -e  "${WHITE}"
     apt install megatools wget
    cd 
     touch ~/.megarc
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
   wget https://prdownloads.sourceforge.net/webadmin/webmin_1.890_all.deb
   dpkg --install webmin_1.890_all.deb
   # on error fault -> libraries -> 
   apt-get install -f -y
   # on port error /etc/init.d/webmin restart
   # editing /etc/webmin/miniserv.conf port 10000 to 10222
  nano /etc/webmin/miniserv.conf
  /etc/init.d/webmin restart
echo -e ${CYAN}"WEBMIN   ${GREEN}INSTALLED Successful"
echo -e ""
echo -e ""
echo -e ""

################################################################################
#                                   USERS                                      #
################################################################################
echo -e  "${YELLOW} ADD USERS"
echo -e  ${WHITE}
 adduser minduim
 usermod -aG  minduim
echo -e " ${CYAN} users added${GREEN}Successfull"
################################################################################
#                                   SAMBA                                      #
################################################################################

echo -e  "${YELLOW} SAMBA INSTALL"
echo -e  ${WHITE}
         apt install -y samba wget 
        # cp /etc/samba/smb.conf /etc/samba/smb.conf_backup
        #touch /etc/samba/smb.conf
    
         echo  "[wds_share]" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000/wds_share" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
         echo ""
         echo "[imagens]" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000/Imagens" >> /etc/samba/smb.conf
	 echo ""
         echo "[media]" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000/Media" >> /etc/samba/smb.conf
         echo ""
         echo "[manutencao]" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000/Manutencao" >> /etc/samba/smb.conf
	 echo ""
         echo "[www]" >> /etc/samba/smb.conf
	 echo "valid users = zombie" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo "path = /var/www" >> /etc/samba/smb.conf
         echo ""
         echo "[programacao]" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo "valid users = zombie" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000/Programacao" >> /etc/samba/smb.conf
         echo ""
         echo "[clients]" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000/Clientes" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo "valid users = zombie" >> /etc/samba/smb.conf
	 echo ""
	 echo "[push]" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000/torrent/torrent-push" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo ""
	 echo "[Game-Server]" >> /etc/samba/smb.conf
	 echo "path = /media/hd2000//media/hd2000/Game-Servers" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo ""
	 echo "[wwww]" >> /etc/samba/smb.conf
	 echo "path = /var/www/" >> /etc/samba/smb.conf
	 echo "writeable = yes" >> /etc/samba/smb.conf
	 echo "valid users = zombie" >> /etc/samba/smb.conf
	 echo ""
	 smbpasswd -a zombie
	 smbpasswd -a minduim
  
	 service smbd restart
        # bash -c 'grep -v -E "^#|^;" /etc/samba/smb.conf_backup | grep . > /etc/samba/smb.conf'
echo -e "${CYAN} SAMBA INSTALLED ${GREEN}Successfull"
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                                   UTORRENT                                   #
################################################################################

echo -e "${YELLOW} UTORRENT INSTALL"
echo -e ${WHITE}
apt-get update
mkdir downloads
cd downloads
wget http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0
mv linux-x64-debian-7-0 linux-x64-debian-7-0.tar.gz
tar -zxvf linux-x64-debian-7-0.tar.gz -C /opt/
chown root:root -R /opt/utorrent-server-alpha-v3_3/
ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver
# apt-get install libssl1.0.0 libssl-dev original squeze
# for debian stretch
apt-get install gdebi -y
wget  http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u9_amd64.deb
wget  http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.13_amd64.deb
apt install gdebi dirmngr
dpkg -i libssl1.0.0_1.0.1t-1+deb8u9_amd64.deb
dpkg -i libssl1.0.0_1.0.2g-1ubuntu4.13_amd64.deb
utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/utorrent
chmod 755 utorrent
cp utorrent /etc/init.d/
cd /etc/init.d/
update-rc.d utorrent defaults
service utorrent start
#systemctl status utorrent.service
service utorrent restart

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
     git clone https://github.com/myanaloglife/py-kms.git
     echo 'kms:x:501:65534::/nonexistent:/bin/false' >> /etc/passwd
     echo 'kms:*:16342:0:99999:7:::' >> /etc/shadow
     echo '[Unit]' > /etc/systemd/system/py-kms.service
     echo 'Description=Python KMS Server' >> /etc/systemd/system/py-kms.service
     echo >> /etc/systemd/system/py-kms.service
     echo '[Service]' >> /etc/systemd/system/py-kms.service
     echo 'ExecStart=/usr/bin/python /opt/py-kms/server.py' >> /etc/systemd/system/py-kms.service
     echo 'User=kms' >> /etc/systemd/system/py-kms.service
     echo 'Restart=always' >> /etc/systemd/system/py-kms.service
     echo 'RestartSec=1' >> /etc/systemd/system/py-kms.service
     echo >> /etc/systemd/system/py-kms.service
     echo '[Install]' >> /etc/systemd/system/py-kms.service
     echo 'WantedBy=multi-user.target' >> /etc/systemd/system/py-kms.service
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
      apt-get install tftpd-hpa -y
#nano /etc/default/tftpd-hpa
      cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.old
      rm /etc/default/tftpd-hpa
      cd /etc/default/
      wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/tftpd-hpa
      /etc/init.d/tftpd-hpa restart
cd 
      apt-get install dnsmasq -y
      cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old
      rm /etc/dnsmasq.conf
cd /etc/
     wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/dnsmasq.conf
     /etc/init.d/dnsmasq restart
cd 
     apt-get install isc-dhcp-server -y
     cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.old
     cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.old
     rm /etc/dhcp/dhcpd.conf
     rm /etc/default/isc-dhcp-server
     cd /etc/default/
     wget https://raw.githubusercontent.com/coelhocarlos/DebianScripts/master/isc-dhcp-server
cd
cd /etc/dhcp/
     wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/dhcpd.conf
cd 
     service isc-dhcp-server restart

     cp /etc/network/interfaces /etc/network/interfaces.old
     rm /etc/network/interfaces
cd /etc/network/
     wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/interfaces
     /etc/init.d/networking restart
     /etc/init.d/tftpd-hpa restart
echo -e "${CYAN} PXE INSTALLED ${GREEN} Successfull" 
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                                MINECRAFT                                     #
################################################################################
echo -e "${YELLOW} INSTALL MINECRAFT"
    echo -e  ${WHITE}
 apt update
 apt install wget screen default-jdk nmap

 useradd -m -r -d /media/hd2000/Game-Servers/minecraft minecraft
cd /media/hd2000/Game-Servers/
 mkdir minecraft
 cd minecraft 
 mkdir survival
 wget -O /media/hd2000/Game-Servers/minecraft/survival/minecraft_server.jar https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar
 bash -c "echo eula=true > /media/hd2000/Game-Servers/minecraft/survival/eula.txt"
 chown -R minecraft /media/hd2000/Game-Servers/minecraft/survival/
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
echo -e "{$BLUE}  systemctl start minecraft@survival"
echo -e "{$RED} for confirm status"
echo -e "{$BLUE}  systemctl status minecraft@survival"
echo -e "{$RED} for execute auto start on boot"
echo -e "{$BLUE}  systemctl enable minecraft@survival"
echo -e "{$RED} check minecraft port"
echo -e "{$BLUE} nmap -p 25565 localhost"
echo -e {$WRITE}
echo -e "*****************************************************"
echo -e {$WRITE}
# systemctl status minecraft@survival
# systemctl start minecraft@survival
# systemctl status minecraft@survival

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

 systemctl stop minecraft@survival
 systemctl enable minecraft@survival
 systemctl start minecraft@survival
# systemctl status minecraft@survival
################################################################################
#                                  UFW                                         #
################################################################################
echo -e "$YELLOW} UFW SET"
echo -e ${WHITE}
     ufw default deny incoming
     ufw default allow outgoing
     ufw allow 22/tcp
     ufw allow 69
     ufw allow in on ens130 to any port 69
     ufw allow 80/tcp
     ufw allow in on ens130 to any port 80
     ufw allow 443/tcp
     ufw allow in on ens130 to any port 443
     ufw allow 2121/tcp
     ufw allow in on ens130 to any port 2121
     ufw allow 8080/tcp
     ufw allow in on ens130 to any port 8080
     ufw allow Apache
     ufw allow webmin
     ufw allow 10000
     ufw allow 11000
     ufw allow samba
     ufw allow 32400
     ufw allow 27015
     ufw allow 27018
     ufw allow 25565
     ufw allow 25567
     ufw allow 1688
     ufw allow 61208
    echo -e  ${RED} 
     ufw enable 
    echo -e  ${WHITE}
echo -e ${CYAN}"UFW SET   ${GREEN}ADDED Successful"
echo -e ""
echo -e ""
echo -e ""



################################################################################
#                               FINISH                                         #
################################################################################
