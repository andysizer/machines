#! /bin/sh

EXTRASDIR=~/apt/extra-packages
mkdir -p ${EXTRASDIR}
cd ${EXTRASDIR}

if [ -e google-chrome-stable_current_amd64.deb ] ; then
    echo "Package already downloaded"
    exit 0
fi

sudo apt-get update

# assume we run gey.py after downloads
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common gnupg2

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

