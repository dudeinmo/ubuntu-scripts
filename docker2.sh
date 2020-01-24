#!/bin/bash
clear

sudo su

sudo apt update
sleep 3
clear

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

sleep 3
clear

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sleep 3
clear

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt-cache policy docker-ce

sleep 3
clear

sudo apt install docker-ce

sleep 3
clear

#sudo systemctl status docker


docker volume create portainer_data
docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
