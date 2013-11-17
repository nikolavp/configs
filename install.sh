#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :

#General installation of hidden files
for x in _*;do
    actual_file=${x/_/.}
    if [[ -h $HOME/$actual_file ]];then
        echo "Another version for $actual_file was found, skipping"
    else
        ln -sf $PWD/"${x}" $HOME/"${actual_file}"
    fi
done

test -h $HOME/.config/awesome || ln -sf $PWD/awesome $HOME/.config/awesome
test -h $HOME/.vim || ln -sf $PWD/vim $HOME/.vim
test -h $HOME/.vimrc || ln -sf $PWD/vim/.vimrc $HOME/.vimrc
test -h $HOME/bin || ln -sf $PWD/bin $HOME/bin

git clone git://github.com/Shougo/neobundle.vim vim/bundle/neobundle.vim
git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master

#This is needed because of the bad directory structure of awesome-freedesktop
ln -sf $PWD/awesome/awesome-freedesktop/freedesktop $PWD/awesome/freedesktop
#cat bg-dvorak-phonetic >> /usr/share/X11/xkb/symbols/bg
#apt-get install xbindkeys -y
#apt-get install awesome awesome-extra zshell tmux gtk-redshift xscreensaver xscreensaver-data-extra xscreensaver-gl-extra parcellite mc

#https://github.com/insanum/gcalcli

#add newer awesome from this ppa
#ppa:klaus-vormweg/awesome
