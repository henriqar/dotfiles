#=============================================================
#
# PERSONAL $HOME/.bashrc FILE for bash-3.0 (or later)
# By Emmanuel Rouat <no-email>
#
# Last modified: Sun Nov 30 16:27:45 CET 2008
# This file is read (normally) by interactive shells only.
# Here is the place to define your aliases, functions and
# other interactive features like your prompt.
#
# The majority of the code here assumes you are on a GNU 
# system (most likely a Linux box) and is based on code found
# on Usenet or internet. See for instance:
#
# http://tldp.org/LDP/abs/html/index.html
# http://www.caliban.org/bash/
# http://www.shelldorado.com/scripts/categories.html
# http://www.dotfiles.org/
#
# This bashrc file is a bit overcrowded -- remember it is just
# just an example. Tailor it to your needs.
#
#
#=============================================================


#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------
if [ -f /etc/bashrc ]; then
        . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi


#------------------------------------------------------------------------------
# Greeting
#------------------------------------------------------------------------------
cowsay "$(fortune)"

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

ulimit -S -c 0          # Don't want any coredumps.
set -o notify
set -o noclobber
set -o ignoreeof
set -o nounset
#set -o xtrace          # Useful for debuging.

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob        # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK         # Don't want my shell to warn me of incoming mail.


export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:bg:fg:ll:h"
export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts ...



#-------------------------------------------------------------
# Greeting, motd etc...
#-------------------------------------------------------------

# Define some colors first:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color
# --> Nice. Has the same effect as using "ansi.sys" in DOS.

#-------------------------------------------------------------
# Shell Prompt
#-------------------------------------------------------------
if [[ "${DISPLAY%%:0*}" != "" ]]; then  
    HILIT=${red}   # remote machine: prompt will be partly red
else
    HILIT=${cyan}  # local machine: prompt will be partly cyan
fi

#===============================================================
#
# ALIASES AND FUNCTIONS
#
# Arguably, some functions defined here are quite big.
# If you want to make this file smaller, these functions can
# be converted into scripts and removed from here.
#
# Many functions were taken (almost) straight from the bash-2.04
# examples.
#
#===============================================================

#-------------------
# Personnal Aliases
#-------------------

# alias config to manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'
            # Assumes LPDEST is defined (default printer)
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'
            # Pretty-print using enscript

alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------
alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'


#-------------------------------------------------------------
# tailoring 'less'
#-------------------------------------------------------------

alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
   # Use this if lesspipe.sh exists
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'


#-------------------------------------------------------------
# spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'


#-------------------------------------------------------------
# A few fun ones
#-------------------------------------------------------------


function xtitle()      # Adds some text in the terminal frame.
{
    case "$TERM" in
        *term | rxvt)
            echo -n -e "\033]0;$*\007" ;;
        *)  
            ;;
    esac
}

# aliases that use xtitle
alias top='xtitle Processes on $HOST && top'
alias make='xtitle Making $(basename $PWD) ; make'
alias ncftp="xtitle ncFTP ; ncftp"



#-------------------------------------------------------------
# File & string-related functions:
#-------------------------------------------------------------


#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------


# Local Variables:
# mode:shell-script
# sh-shell:bash
# End:

