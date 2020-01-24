#!/bin/bash
clear
echo ***************************
echo *   APT UPDATE            *
echo ***************************

sudo apt update

echo **********************************
echo *   Install required programs    *
echo **********************************
sleep 1

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

echo **********************************
echo *   Download Docker Key          *
echo **********************************
sleep 1

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo **********************************
echo *   Add Docker Repository        *
echo **********************************
sleep 1

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt-cache policy docker-ce

echo **********************************
echo *   Install Docker               *
echo **********************************
sleep 1

sudo apt install docker-ce

echo **********************************
echo *   Docker Status?               *
echo **********************************
sleep 1

sudo systemctl status docker

echo **********************************
echo *   Add Portainer to Docker      *
echo **********************************
sleep 1

docker volume create portainer_data
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

