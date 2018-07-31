#!/bin/bash

## Ticket Evolution
## ${HOME}/.bash_profile 

/bin/date
if [ -e ${HOME}/.bashrc ]; then
  source ${HOME}/.bashrc
fi

## keychain
if [ -e ${HOME}/.ssh/id_rsa ]; then
  /usr/bin/keychain -q $HOME/.ssh/id_rsa
  source $HOME/.keychain/$HOSTNAME-sh
fi
