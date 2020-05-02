#!/bin/sh

export ANSIBLE_CONFIG=./ansible.cfg
INITUSER=../playbooks/init_user.yml
PASSWORDLESS=../playbooks/passwordless.yml

ansible-playbook --become-method su --ask-su-pass ${INITUSER}
ansible-playbook ${PASSWORDLESS}
