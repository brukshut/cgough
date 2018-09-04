#!/bin/bash

## .bash_profile 
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
date

[ -e ${HOME}/.bashrc ] && source ${HOME}/.bashrc

## keychain
if [ -e ${HOME}/.ssh/id_rsa ]; then
  keychain -q ${HOME}/.ssh/id_rsa
  source ${HOME}/.keychain/$HOSTNAME-sh
fi
