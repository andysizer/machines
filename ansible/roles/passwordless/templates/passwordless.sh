#! /bin/sh -x

# need ssh-agent to be running
AGENTPID="XX$(pgrep ssh-agent)"
if [ "${AGENTPID}" = "XX" ] ; then
    # agent not running - if ssh-add not present it isn't installed
    if [ "XX$(which ssh-add)" = "XX" ] ; then
	# install openshh-server
	if ! sudo apt-get -y install openssh-server ; then
	    echo "Error: Couldn't install ssh-agent."
	    exit 1
	fi
    else
	echo "Error: ssh-agent not running."
	exit 1
    fi
fi

# we need ~{{ user }}/.ssh/id_rsa and we need 0700 permissions for ~/.ssh and 0400 for ~/.ssh/id_rsa
KEYDIR=~{{ user }}/.ssh
USERKEY=${KEYDIR}/id_rsa

if [ ! -e ${USERKEY} ] ; then
    echo "ERROR: ${USERKEY} does not exist"
fi

if [ "$(stat -c %a ${KEYDIR})" = "700" ] && [ "$(stat -c %a ${USERKEY})" = "400" ] ; then
    unset DISPLAY
    ssh-add ${USERKEY}
else
    echo "Error: Permissions problem - ${USERKEY}"
    exit 1
fi
