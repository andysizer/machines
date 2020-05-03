#! /bin/sh

VENVSCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

COMMENT="# Added by Ansible role 'python3_virtualwrapper'"
STATEMENT1="source ${VENVSCRIPT}"
STATEMENT2="export WORKON_HOME=$HOME/.virtualenvs"
BASHRC=~{{ user }}/.bashrc

if ! grep -q "${COMMENT}" ${BASHRC} ; then
    echo "Setting up virtualenvwrapper..."
    echo "" >> ${BASHRC}
    echo ${COMMENT} >> ${BASHRC}
    echo ${STATEMENT1} >> ${BASHRC}
    echo ${STATEMENT2} >> ${BASHRC}
fi




