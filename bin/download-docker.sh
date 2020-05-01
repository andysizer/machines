#! /bin/sh -e

EXTRASDIR=~/apt/extra-packages
mkdir -p ${EXTRASDIR}
cd ${EXTRASDIR}

if [ -e docker-ce_*.deb ] && [ -e docker-ce-cli_*.deb ] && [ -e containerd.io*.deb ] ; then
    echo "Packages already downloaded."
    exit 0
fi

sudo apt update

# assume we run gey.py after downloads
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common gnupg2

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

sudo apt update

apt-get download docker-ce docker-ce-cli containerd.io

