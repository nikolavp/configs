# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ack=ack-grep
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

#Start my options

#Don't print the stack 
pushd()
{
    builtin pushd "$@" > /dev/null
}

popd()
{
    #Checks if we have one argument
    if [[ $1 -ge 0 ]]; then
        count=0
        while [[ count -ne $1 ]];do
            builtin popd > /dev/null
            count=$((count+1))
        done
    else
        builtin popd "$@"
    fi
}

mycd()
{
    if [[ $# == 0 ]];then
        pushd "$HOME"
    elif [[ $# == 1 && $1 == '-' ]];then
        shift
        builtin popd "$@" > /dev/null
    else
        pushd "$@"
    fi 
}

list()
{
    tree -d -I "target*|[Bb]uild"
}

cleanpy(){
    rm -f *.pyc
}

#some bash goodies
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s cdspell
alias rm='rm -i'
alias mv='mv -i'
alias clean=clean

alias cd='mycd'
alias _='popd'

if [ "$PS1" ] ; then  
   mkdir -m 0700 /dev/cgroup/cpu/user/$$ > /dev/null 2>&1
   echo $$ > /dev/cgroup/cpu/user/$$/tasks
   echo "1" > /dev/cgroup/cpu/user/$$/notify_on_release
fi


#Prefer vim for everything. Some strange distros like ubuntu have bad defaults like ed -.-
export TERM=xterm-256color
export PAGER=less
export GIT_EDITOR=vim
export GIT_PAGER=less
export ONTO_SVN="https://svn.ontotext.com/svn/"
export JOCI_SVN="${ONTO_SVN}joci/trunk"
export ROCI_SVN="${ONTO_SVN}roci"
export NI4=ni4.innovantage.co.uk
export WORK=$HOME/workspace
export JOCI=$WORK/joci
export ROCI=$WORK/roci
export PYTHONSTARTUP=/home/nikolavp/.pystartup
export EDITOR=vim

export PATH="~/Desktop/android-sdk-linux_x86/tools:~/bin/:$PATH"

MOZILLA_DIST=/home/nikolavp/onto-dist
