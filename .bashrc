#!/bin/bash

##
## .bashrc for cgough
##

## functions
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

function berks_upload {
  ${HOME}/.rbenv/shims/berks upload ${PWD##*/} --no-freeze --force
}
## end functions

unalias -a
HISTCONTROL=ignoredups
HISTSIZE=20000
PAGER=less
TERM=xterm
MANPATH=/usr/share/man:/usr/local/share/man
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:${HOME}/bin
PATHDIR=""
for DIR in $PATHDIR; do
  for BINDIR in bin sbin; do
    [[ -d ${DIR}/${BINDIR} ]] && PATH=$PATH:${DIR}/${BINDIR}
  done
  for MANDIR in ${DIR}/man ${DIR}/share/man; do
    [[ -d $MANDIR ]] && MANPATH=$MANPATH:$MANDIR
  done
done

## PS1
## bash built-in colors  
txtblk='\[\e[0;30m\]' ## black regular
txtred='\[\e[0;31m\]' ## red
txtgrn='\[\e[0;32m\]' ## green
txtylw='\[\e[0;33m\]' ## yellow
txtblu='\[\e[0;34m\]' ## blue
txtpur='\[\e[0;35m\]' ## purple
txtcyn='\[\e[0;36m\]' ## cyan
txtwht='\[\e[0;37m\]' ## white
bldblk='\[\e[1;30m\]' ## black  bold
bldred='\[\e[1;31m\]' ## red    bold
bldgrn='\[\e[1;32m\]' ## green  bold
bldylw='\[\e[1;33m\]' ## yellow bold
bldblu='\[\e[1;34m\]' ## blue   bold
bldpur='\[\e[1;35m\]' ## purple bold 
bldcyn='\[\e[1;36m\]' ## cyan   bold
bldwht='\[\e[1;37m\]' ## white  bold
unkblk='\[\e[4;30m\]' ## black  underline
undred='\[\e[4;31m\]' ## red    underline
undgrn='\[\e[4;32m\]' ## green  underline
undylw='\[\e[4;33m\]' ## yellow underline
undblu='\[\e[4;34m\]' ## blue   underline
undpur='\[\e[4;35m\]' ## purple underline
undcyn='\[\e[4;36m\]' ## cyan   underline
undwht='\[\e[4;37m\]' ## white  underline
bakblk='\[\e[40m\]'   ## black  background
bakred='\[\e[41m\]'   ## red    background
badgrn='\[\e[42m\]'   ## green  background
bakylw='\[\e[43m\]'   ## yellow background
bakblu='\[\e[44m\]'   ## blue   background
bakpur='\[\e[45m\]'   ## purple background
bakcyn='\[\e[46m\]'   ## cyan   background
bakwht='\[\e[47m\]'   ## white  background
txtrst='\[\e[0m\]'    ## text reset

FQDN=`/bin/hostname -f`
HOSTNAME=`/bin/hostname`
blue="${txtrst}[${HOSTNAME}:\w] ${bldblu}\u${txtrst}% "
red="${txtrst}[${HOSTNAME}:\w] ${bldred}\u${txtrst}% "
purple="${txtrst}[${HOSTNAME}:\w] ${bldpur}\u${txtrst}% "
yellow="${txtrst}[${HOSTNAME}:\w] ${bldylw}\u${txtrst}% "
green="${txtrst}[${HOSTNAME}:\w] ${bldgrn}\u${txtrst}% "
rasta="${txtrst}${bldred}[${txtrst}${bldylw}${HOSTNAME}:\w${txtrst}${bldred}]${txtrst} ${bldgrn}\u%${txtrst} "
PS1=$rasta

## check for emacs
alias emacs=/usr/local/bin/emacs
[[ `type -p emacs` ]] &&
  ( EDITOR=emacs
    alias emacs="emacs -nw"
    alias emasc="emacs -nw" ) || EDITOR=vim

## rbenv
for dir in bin shims; do
  [[ -d ${HOME}/.rbenv/${dir} ]] && PATH=${PATH}:${HOME}/.rbenv/${dir}
done
[[ $(which rbenv) ]] && eval "$(rbenv init -)"

## pyenv
[[ $(which pyenv) ]] && eval "$(pyenv init -)"

## kubectl completion
[[ $(which kubectl) ]] && source <(kubectl completion bash)

## export variables
export HISTCONTROL HISTSIZE PAGER PATH MANPATH PS1 TERMINFO TERM EDITOR

## options
set -o emacs

## aliases
alias clean="rm *~ >& /dev/null; rm .*~ >& /dev/null; rm \#* >& /dev/null"

## call functions
xtitle
