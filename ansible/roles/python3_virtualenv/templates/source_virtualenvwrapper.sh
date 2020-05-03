#! /bin/sh

VENVSCRIPT=/usr/share/virtualenv/virtualenvwrapper_lazy.sh

COMMENT="# Added by Ansible role 'python3_virtualwrapper'"
STATEMENT="source ${VENVSCRIPT}"
BASHRC=~{{ user }}/.bashrc

if ! grep -q "${COMMENT}" ${BASHRC} ; then
    echo "Setting up virtualenvwrapper..."
    echo "" >> ${BASHRC}
    echo ${COMMENT} >> ${BASHRC}
    echo ${STATEMENT} >> ${BASHRC}
fi




