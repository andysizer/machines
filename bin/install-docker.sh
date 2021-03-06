#! /bin/sh

sudo apt -y install apt-transport-https ca-certificates curl software-properties-common gnupg2

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

sudo apt update
sudo apt -y install docker-ce

sudo systemctl status docker

docker -v

sudo usermod -aG docker $USER
