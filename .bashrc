#!/bin/bash

##
## .bashrc for cgough
##

## functions
function add_paths {
  local directory=$1
  for dir in bin sbin; do
    [[ -d ${directory}/${dir} ]] && PATH=$PATH:${directory}/${dir}
  done
  for dir in man share/man; do
    [[ -d ${directory}/${dir} ]] && MANPATH=$MANPATH:${directory}/${dir}
  done
}

function darwin_openssl {
  ## darwin ships with libressl
  ## this ensures we can find a brew managed openssl
  local openssl_version=$1
  [[ $(uname) == 'Darwin' ]] &&
    PATH=/usr/local/Cellar/openssl\@1.1/${openssl_version}/bin:$PATH
}

function xtitle {
  case $TERM in
    vt100 | xterm* | dtterm )
      local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
      ;;
    *)
      local TITLEBAR=''
      ;;
  esac
 export PS1=$PS1$TITLEBAR
}
## end functions

HISTCONTROL=ignoredups
HISTSIZE=20000
PAGER=less
TERM=xterm-256color
MANPATH=/usr/share/man:/usr/local/share/man
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:${HOME}/bin
MAIL=${HOME}/Maildir/

## ensure we can find homebrew openssl on darwin
darwin_openssl 1.1.1g

## gopath
GOPATH=${HOME}/go

## pyenv
[[ $(command -v pyenv) ]] && eval "$(pyenv init -)"

## kubectl completion
[[ $(command -v kubectl) ]] && source <(kubectl completion bash)

## set editor
[[ `type -p emacs` ]] && EDITOR=emacs || EDITOR=vim

## options
## emacs keybindings
set -o emacs

## aliases
unalias -a
alias emasc=emacs
alias clean="rm *~ >& /dev/null; rm .*~ >& /dev/null; rm \#* >& /dev/null"
alias dockrn="docker run --detach-keys='ctrl-p'"

## PS1
source .bash_colors
FQDN=`/bin/hostname -f`
HOSTNAME=`/bin/hostname`
blue="${txtrst}[${HOSTNAME}:\w] ${bldblu}\u${txtrst}% "
red="${txtrst}[${HOSTNAME}:\w] ${bldred}\u${txtrst}% "
purple="${txtrst}[${HOSTNAME}:\w] ${bldpur}\u${txtrst}% "
yellow="${txtrst}[${HOSTNAME}:\w] ${bldylw}\u${txtrst}% "
green="${txtrst}[${HOSTNAME}:\w] ${bldgrn}\u${txtrst}% "
rasta="${txtrst}${bldred}[${txtrst}${bldylw}${HOSTNAME}:\w${txtrst}${bldred}]${txtrst} ${bldgrn}\u%${txtrst} "
PS1=$blue

## export variables
export HISTCONTROL HISTSIZE PAGER PATH MANPATH PS1 TERMINFO TERM EDITOR GOPATH MAIL
export  BASH_SILENCE_DEPRECATION_WARNING=1

## call functions
xtitle
