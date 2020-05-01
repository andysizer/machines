#! /bin/sh

EXTRASDIR=~/apt/extra-packages
mkdir -p ${EXTRASDIR}
cd ${EXTRASDIR}

if [ -e code_*.deb ] ; then
    echo "Package already downloaded."
    exit 0
fi

sudo apt-get update

# assume we run gey.py after downloads
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common gnupg2

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
apt-get download code # or code-insiders
