#! /bin/sh -e

PYCHARMBASE=pycharm-community-2020.1
PYCHARMTAR=${PYCHARMBASE}.tar.gz
PYCHARMURL=https://download.jetbrains.com/python/${PYCHARMTAR}
TDIR=~/Programs/pycharm
PYCHARMBIN=${TDIR}/${PYCHARMBASE}/bin
PYCHARMINSTALLEDFLG="${TDIR}/.${PYCHARMBASE}"

if [ -e ${PYCHARMINSTALLEDFLG} ] ; then
    echo "Pycharm (${PYCHARMBASE}) already installed."
    exit 0
fi

mkdir -p ${TDIR}
if [ ! -e ${TDIR}/${PYCHARMTAR} ] ; then
    if ! wget -q -O ${TDIR}/${PYCHARMTAR} ${PYCHARMURL} ; then
	echo "pycharm download failed. Go to 'https://www.jetbrains.com/pycharm/download/#section=linux' to download"
	exit 1
    fi
fi

cd ${TDIR}

tar -xvf ${PYCHARMTAR}

if [ ! -d ${PYCHARMBASE} ] ; then
    echo "Error: unexpected file layout. Install by hand".
    exit 1
fi

cd ${PYCHARMBIN}

# Add ${PYCHARMBIN} to path

COMMENT="# ${PYCHARMBIN} added to PATH by 'install-pycharm.sh'"
STATEMENT="PATH=\"${PYCHARMBIN}:${PATH}\""
BASHRC=~/.bashrc

if ! grep -q "${COMMENT}" ${BASHRC} ; then
    echo "" >> ${BASHRC}
    echo ${COMMENT} >> ${BASHRC}
    echo ${STATEMENT} >> ${BASHRC}
fi

touch ${PYCHARMINSTALLEDFLGK}

./pycharm.sh &
