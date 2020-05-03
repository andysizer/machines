#!/bin/sh

export ANSIBLE_CONFIG=./ansible.cfg

INITUSER=../playbooks/init_user.yml
PASSWORDLESS=../playbooks/passwordless.yml
VIRTUALENV=../playbooks/python3_virtualenv.yml

ansible-playbook -K --become-method=su -e user=${USER} ${INITUSER}
ansible-playbook -e user=${USER} ${PASSWORDLESS}
ansible-playbook -e user=${USER} ${VIRTUALENV}
