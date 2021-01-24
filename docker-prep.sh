#!/bin/bash

##########    Samba Share Prep  ###########
clear

function pause(){
   read -p "$*"
}

echo "**************************************************"
echo "             UPDATING FSTAB"
echo "**************************************************"
echo 
#Version One
sudo apt install samba samba-common-bin smbclient cifs-utils -Y
sudo echo "//10.10.10.20/SambaShares /mnt cifs vers=2.1, credentials=/.smb-creds,uid=0,gid=0,file_mode=0777,dir_mode=0777 0 0" >> /etc/fstab
#//10.10.10.20/SambaShares /mnt/shares cifs _netdev,credentials=/.smb-creds,uid=1000,gid=1000,rw,file_mode=0777,dir_mode=0777 0 0
sudo mkdir /mnt/shares

pause 'Press [Enter] key to continue...'

clear
echo "**************************************************"
echo "             CONFIRMING FSTAB"
echo "**************************************************"
echo
cat /etc/fstab
echo
pause 'Press [Enter] key to continue...'

clear

#Version Two
#read -p 'Enter SambaShare URL : ' smbshare
#read -p 'Enter Share Mount Point : ' smbmount
#echo "$smbshare /mnt cifs vers=2.1, credentials=/.smb-creds,uid=0,gid=0,file_mode=0777,dir_mode=0777 0 0" >> /etc/fstab

#Version Three
#read -p 'Enter SambaShare URL : ' smbshare
#read -p 'Enter Share Mount Point : ' smbmount
#echo "$smbshare $smbmount cifs vers=2.1, credentials=/.smb-creds,uid=0,gid=0,file_mode=0777,dir_mode=0777 0 0" >> /etc/fstab

#echo Please enter Samba Credentials .....
echo "**************************************************"
echo "          Please enter Samba Credentials"
echo "**************************************************"
echo
read -p 'Username: ' smbuser
read -sp 'Password: ' smbpass
read -sp 'Confirm: ' smbpass2

while [ "$smbpass" != "$smbpass2" ];
do
    echo 
    echo "Please try again"
    read -sp 'Password: ' smbpass
    read -sp 'Confirm: ' smbpass2
done

sudo echo "username=$smbuser" >> /.smb-creds
sudo echo "password=$smbpass2" >> /.smb-creds

clear
echo "**************************************************"
echo "          Confirming /.smb-creds"
echo "**************************************************"
echo
#echo "Confirming /.smb-creds"
cat /.smb-creds
echo
pause 'Press [Enter] key to continue...'
sudo mount -a
clear

##########    DOCKER INSTALL  ###########

clear
echo "**************************************************"
echo "**       Update & Upgrade Apt                  ***"
echo "**************************************************"
sleep 3

sudo apt-get install apt-transport-https ca-certificates curl wget software-properties-common -y
sudo apt-get update -y
sudo apt-get upgrade -y

clear
echo "**************************************************"
echo "** Install Docker Repository and Install Docker***"
echo "**************************************************"
sleep 3

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt-get update -y

apt-cache policy docker-ce

sudo apt-get install docker-ce -y

service=docker
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
	echo "**************************************************"
	echo "** Install Portainer Container on Docker       ***"
	echo "**************************************************"
	sleep 3
	
	sudo docker volume create portainer_data
	sudo docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
	
	_MyIP="$( hostname -i )"
	echo "Open the following address in a browser to access Portainer"
	echo "http://$_MyIP:9000"

else
	echo "Docker is not running"
fi
