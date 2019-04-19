#!/bin/bash

## .bash_profile 
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

## keychain
[[ -e ${HOME}/.ssh/id_rsa ]] &&
  ( keychain -q ${HOME}/.ssh/id_rsa
    source ${HOME}/.keychain/$HOSTNAME-sh )

## what day is it?
date

## refresh dotfiles
[[ -d ${HOME}/.dotfiles ]] &&
  ( cd ${HOME}/.dotfiles
    git checkout
    cd ${HOME} )

## source .bashrc
[[ -e ${HOME}/.bashrc ]] && source ${HOME}/.bashrc
