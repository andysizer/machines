#! /bin/sh

sudo apt -y install apt-transport-https ca-certificates curl software-properties-common gnupg2

cd /tmp

wget http://www.scootersoftware.com/bcompare-4.3.4.24657_amd64.deb
sudo apt-get update
sudo apt-get -y install gdebi-core
sudo gdebi bcompare-4.3.4.24657_amd64.deb

