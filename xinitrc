#!/bin/sh
# $XConsortium: xinitrc.cpp,v 1.4 91/08/22 11:41:34 rws Exp $

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap


#set the an alternative layout and switch with caps lock
setxkbmap -model pc104 -option "grp:caps_toggle" -layout "us,bg" -variant ",phonetic"

#some fonts on arch are installed in local
xset +fp /usr/share/fonts/local
xset fp rehash

# merge in defaults and keymaps
if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    xmodmap $usermodmap
fi

export BROWSER=`which google-chrome`
export EDITOR=`which gvim`
export FILE_MANAGER_APP=`which nautilus`
export VIDEO_APP=`which mplayer`


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# start some nice programs
if [ -f $HOME/.Xclients ]; then
    exec $HOME/.Xclients
fi

