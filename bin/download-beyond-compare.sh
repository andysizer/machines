#! /bin/sh

EXTRASDIR=~/apt/extra-packages
mkdir -p ${EXTRASDIR}
cd ${EXTRASDIR}

BCOMPARE=bcompare
VER=4.3.4.24657

if [ -e "${BCOMPARE}-${VER}_amd64.deb" ] ; then
    UNWANTED="XX$(ls ${BCOMPARE}* | grep -v ${VER})"
    if [ "${UNWANTED}" != "XX" ] ; then
	rm -f ${UNWANTED}
    fi
    echo "Package already downloaded"
    exit 0
fi

sudo apt-get update

# assume we run gey.py after downloads
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common gnupg2

wget "http://www.scootersoftware.com/${BCOMPARE}-${VER}_amd64.deb"
