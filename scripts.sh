#! /bin/bash
clear

echo "[ 1 ] Update APT-GET"
echo "[ 2 ] Upgrade APT-GET"
echo "[ 3 ] Install Webmin"
echo "[ 4 ] Install Samba"
echo "[ 5 ] Install Qemu Agent (Proxmox)"
echo "[ 6 ] Install Docker"
echo "[ 7 ] Install Portainer"
echo "[ 8 ] Install Watchtower"
echo "[ 9 ] HassOs on Proxmox"
echo "[ X ] Exit"
echo
read -p 'Selection : ' uselect

case $uselect in
  1)
    echo "[ Updating APT-GET ]"
    sleep 2
    sudo apt-get update
    ;;
  2)
    echo "[ Upgrading APT-GET ]"
    sleep 2
    sudo apt-get upgrade
    ;;
  3)
    clear
    echo "[ Installing Webmin ]"
    sleep 2
    wget -qO - https://raw.githubusercontent.com/dudeinmo/ubuntu-scripts/master/webmin-install.sh | bash -s dudeinmo
    ;;
  4)
    clear
    echo "[ Installing Samba ]"
    sleep 2
    sudo apt-get install samba -y
    ;;
  5)
    clear
	apt-get install qemu-guest-agent
	systemctl start qemu-guest-agent
	;;
  6)
    clear
    ##########    Installing Required Utilities  ###########

	sleep 3	
	
	sudo apt-get install apt-transport-https ca-certificates curl wget software-properties-common -y
	
	sleep 3
	
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
		echo "**             Docker is running               ***"
		echo "**************************************************"
		sleep 3
	else
		echo "**************************************************"
		echo "**           Docker is NOT running             ***"
		echo "**************************************************"
	fi
    sleep 2
    ;;
  7)
    clear
    echo "**************************************************"
	echo "** Install Portainer Container on Docker       ***"
	echo "**************************************************"
	sleep 3
	
	sudo docker volume create portainer_data
	sudo docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

	sudo docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
	
	_MyIP="$( hostname -i )"
	echo "Open the following address in a browser to access Portainer"
	echo "http://$_MyIP:9000"
    sleep 2
    ;;
  8)
    clear
    echo "[ Not Available Yet ]"
    sleep 2
    ;;
  9)
    clear
    echo "[ Install HassOS ]"
    sleep 2
    wget -qO - https://raw.githubusercontent.com/dudeinmo/ubuntu-scripts/master/hassos-proxmox.sh | bash -s local-lvm
    ;;
    
  X)
    clear
    exit 1
    ;;
esac
sleep 2
clear

