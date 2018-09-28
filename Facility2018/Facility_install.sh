
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
apt install -y sudo wget
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
#                           SCRIPTS                                            #
################################################################################
 echo -e "${YELLOW} ADDING SCRIPTS"
  echo -e  ${WHITE}
cd
mkdir ~/.scripts
cd ~/.scripts
sudo wget https://raw.githubusercontent.com/coelhocarlos/pos-install/master/Facility2018/scripts/mega_send.sh
sudo wget https://github.com/coelhocarlos/pos-install/blob/master/Facility2018/scripts/mysql_dump.sh
sudo wget https://raw.githubusercontent.com/coelhocarlos/pos-install/master/Facility2018/scripts/duck.sh
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
#                           MEGA UPLOADER                                      #
################################################################################
 echo -e "${YELLOW} MEGATOOLS INSTALL"
    echo -e  "${WHITE}"
    sudo apt install megatools wget
    cd 
    sudo touch ~/.megarc
    echo "[Login]" >> ~/.megarc
    echo "Username = facilitybackup2017@gmail.com" >> ~/.megarc
    echo "Password = " >> ~/.megarc
 echo -e "${CYAN} MEGATOOLS  INSTALLED ${GREEN}Successfull"   
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
  #nano /etc/webmin/miniserv.conf
  #/etc/init.d/webmin restart
echo -e ${CYAN}"WEBMIN   ${GREEN}INSTALLED Successful"
echo -e ""
echo -e ""
echo -e ""
################################################################################
#                                   USERS                                      #
################################################################################
echo -e  "${YELLOW} ADD USERS"
echo -e  ${WHITE}
sudo adduser facility
sudo adduser uniloc
sudo adduser guilherme
sudo adduser paulo
sudo adduser secretaria
sudo adduser financeiro
sudo adduser outlook
sudo adduser tftpd
#sudo usermod -aG sudo facility

echo -e " ${CYAN} users added${GREEN}Successfull"
################################################################################
#                                   SAMBA                                      #
################################################################################

echo -e  "${YELLOW} SAMBA INSTALL"
echo -e  ${WHITE}
        sudo apt install -y samba wget 
        #sudo cp /etc/samba/smb.conf /etc/samba/smb.conf_backup
        #touch /etc/samba/smb.conf
        
        sudo echo "[facility]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/facility/" >> /etc/samba/smb.conf
	sudo echo ""
	
        sudo echo "[uniloc]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/uniloc/" >> /etc/samba/smb.conf
  
        sudo echo "[remessa]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/uniloc/remessa/" >> /etc/samba/smb.conf
	sudo echo ""
	
        sudo echo "[retorno]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/uniloc/retorno/" >> /etc/samba/smb.conf
	sudo echo ""
	
        sudo echo "[banco]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/uniloc/banco/" >> /etc/samba/smb.conf
	sudo echo ""
	
	sudo echo "[backup]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/uniloc/backup/" >> /etc/samba/smb.conf
	sudo echo ""
  
        sudo echo "[guilherme]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/guilherme/" >> /etc/samba/smb.conf
	sudo echo ""
	
        sudo echo "[paulo]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/paulo/" >> /etc/samba/smb.conf
	sudo echo ""
	
	sudo echo "[secretaria]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/secretaria/" >> /etc/samba/smb.conf
	sudo echo ""
	
	sudo echo "[financeiro]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/financeiro/" >> /etc/samba/smb.conf
	sudo echo ""
	
	sudo echo "[outlook]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/outlook/" >> /etc/samba/smb.conf
	sudo echo ""
        
        sudo echo "[tftpd]" >> /etc/samba/smb.conf
	sudo echo "writeable = yes" >> /etc/samba/smb.conf
	sudo echo "path = /home/tftpd/" >> /etc/samba/smb.conf
	sudo echo ""
	
	sudo smbpasswd -a ccadm
	sudo smbpasswd -a paulo
	sudo smbpasswd -a facility
        sudo smbpasswd -a uniloc
        sudo smbpasswd -a guilherme
	sudo smbpasswd -a secretaria
	sudo smbpasswd -a financeiro
	sudo smbpasswd -a outlook
        sudo smbpasswd -a tftpd
	
	sudo service smbd restart
        #sudo bash -c 'grep -v -E "^#|^;" /etc/samba/smb.conf_backup | grep . > /etc/samba/smb.conf'
echo -e "${CYAN} SAMBA INSTALLED ${GREEN}Successfull"
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
echo -e ""
################################################################################
#                                  PXE                                         #
################################################################################
# tftp PXE
apt-get install tftpd-hpa -y
#nano /etc/default/tftpd-hpa
cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.old
rm /etc/default/tftpd-hpa
cd /etc/default/
wget https://raw.githubusercontent.com/coelhocarlos/pos-install/master/Facility2018/pxe/tftpd-hpa
/etc/init.d/tftpd-hpa restart
cd 
apt-get install dnsmasq -y
cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old
rm /etc/dnsmasq.conf
cd /etc/
wget https://raw.githubusercontent.com/coelhocarlos/pos-install/master/Facility2018/pxe/dnsmasq.conf
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
wget https://raw.githubusercontent.com/coelhocarlos/pos-install/master/Facility2018/pxe/interfaces
/etc/init.d/networking restart
################################################################################
#                                  UFW                                         #
################################################################################
echo -e "$YELLOW} UFW SET"
echo -e ${WHITE}
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow 22/tcp
    sudo ufw allow 69
    sudo ufw allow 53
    sudo ufw allow in on enp1s0 to any port 69
    sudo ufw allow 80/tcp
    sudo ufw allow in on enp1s0 to any port 80
    sudo ufw allow 443/tcp
    sudo ufw allow in on enp1s0 to any port 443
    sudo ufw allow 2121/tcp
    sudo ufw allow in on enp1s0 to any port 2121
    sudo ufw allow 8080/tcp
    sudo ufw allow in on enp1s0 to any port 8080
    sudo ufw allow apache
    sudo ufw allow webmin
    sudo ufw allow php
    sudo ufw allow ssh
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
#                               ISPCONFIG                                      #
################################################################################
apt-get update && apt-get upgrade
apt-get install unzip 
cd /tmp
wget --no-check-certificate https://github.com/servisys/ispconfig_setup/archive/master.zip
unzip master.zip
cd ispconfig_setup-master/
./install.sh
################################################################################
#                                  FIM                                         #
################################################################################
