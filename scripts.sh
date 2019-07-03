#! /bin/bash
clear

echo "[ 1 ] Update APT-GET"
echo "[ 2 ] Upgrade APT-GET"
echo "[ 3 ] Install Webmin"
echo "[ 4 ] Install Samba"
echo "[ 9 ] HassOs on Proxmox
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
