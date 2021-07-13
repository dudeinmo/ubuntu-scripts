#!/bin/bash

##########    DOCKER INSTALL  ###########
function pause(){
   read -p "$*"
}

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
