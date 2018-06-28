#!/bin/bash

## .bashrc for cgough

## FUNCTIONS
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

## END FUNCTIONS

unalias -a

PYTHON_EGG_CACHE=/tmp
HISTCONTROL=ignoredups
HISTSIZE=20000
PAGER=less
TERM=xterm
MANPATH=/usr/share/man:/usr/local/share/man
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin
PATHDIR="${HOME}/.rvm/bin /usr/local/opt/elasticsearch@5.6 /usr/local/opt/kibana@5.6"
PATHDIR="$PATHDIR"
for DIR in $PATHDIR; do
  for BINDIR in bin sbin; do
    if [ -d ${DIR}/${BINDIR} ]; then 
      PATH=$PATH:${DIR}/${BINDIR}
    fi
  done
  for MANDIR in ${DIR}/man ${DIR}/share/man; do
    if [ -d $MANDIR ]; then
      MANPATH=$MANPATH:$MANDIR
    fi
  done
done

JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME PATH

if [ -f ~/.aws ]; then
  source ~/.aws
fi

## PS1

## Bash built-in colors.  
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

FQDN=`/bin/hostname -f`
PQDN=${FQDN%.tedc.co}
HOSTNAME=`/bin/hostname`
ENVIRON=${PQDN#$HOSTNAME.}

blue="${txtrst}[${PQDN}:\w] ${bldblu}\u${txtrst}% "
red="${txtrst}[${PQDN}:\w] ${bldred}\u${txtrst}% "
purple="${txtrst}[${PQDN}:\w] ${bldpur}\u${txtrst}% "
yellow="${txtrst}[${PQDN}:\w] ${bldylw}\u${txtrst}% "
green="${txtrst}[${PQDN}:\w] ${bldgrn}\u${txtrst}% "

case $ENVIRON in 
  prod)
    PS1=$red
    ;;
  sandbox)
    PS1=$blue
    ;;
  staging)
    PS1=$green
    ;;
  *)
    PS1=$red
    ;;
esac

## Check for vim
if [ `type -p vim` ]; then 
  alias vi="vim"
fi

alias emacs=/usr/local/bin/emacs

## Check for emacs
if [ `type -p emacs` ]; then
  EDITOR=emacs
  alias emacs="emacs -nw"
  alias emasc="emacs -nw"
else
  EDITOR=vim
fi

alias graphite='ssh -q -N -L 8080:admin002.prod.tedc.co:8080 cgough@gw &'
alias cheft="${HOME}/bin/autochef.sh"
alias rest="ssh -q -N -L 9070:10.0.0.5:9070 gw &"

## Export variables.
export HISTCONTROL HISTSIZE PAGER PATH MANPATH PS1 TERMINFO TERM EDITOR SVN_EDITOR

## Options here.
set -o emacs

## Aliases.
alias clean="rm *~ >& /dev/null; rm .*~ >& /dev/null; rm \#* >& /dev/null"

## Call functions.
xtitle

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
