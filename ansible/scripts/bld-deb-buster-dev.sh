#!/bin/sh

export ANSIBLE_CONFIG=./ansible.cfg
PLAYBOOK=../playbooks/debian-buster-dev.yml

ansible-playbook -vvvv --become-method su --ask-su-pass ${PLAYBOOK}
