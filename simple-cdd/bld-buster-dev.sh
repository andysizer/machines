#! /bin/sh

# Need a bigger disktype - used/passed on by debian-cd
export DISKTYPE=DVD

build-simple-cdd --dist buster -p deb-buster-dev -a deb-buster-dev --verbose --debug --logfile ./deb-buster-dev.log \
		 --local-packages "$(ls ~/apt/extra-packages/*)"
