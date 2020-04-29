#! /bin/sh

# need openssh-server and id_rsa

# execute as root - we haven't got sudoers set up properly yet
su - -c 'apt-get update'
su - -c 'apt-get -y install openssh-server'

# we need ~/.ssh/id_rsa and we need 0700 permissions for ~/.ssh and 0400 for ~/.ssh/id_rsa

if [ "$(stat -c %a ~/.ssh)" -eq 700 ] && [ "$(stat -c %a ~/.ssh/id_rsa)" -eq 400 ] ; then
    ssh-add ~/.ssh/id_rsa
else
    echo "Persmissions problem: ~/.ssh/id_rsa"
fi

											

