#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :

#General installation of hidden files
for x in _*; do
    if [ "$x" = "_fonts.conf" ]; then
        continue
    fi
    actual_file=${x/_/.}
    if [[ -L $HOME/$actual_file ]]; then
        echo "Another version for $actual_file was found, skipping"
    else
        ln -sf $PWD/"${x}" $HOME/"${actual_file}"
    fi
done

mkdir -p $HOME/.config/fontconfig
test -h $HOME/.config/fontconfig/fonts.conf || ln -sf $PWD/_fonts.conf $HOME/.config/fontconfig/fonts.conf
test -h $HOME/.config/awesome || ln -sf $PWD/awesome $HOME/.config/awesome
test -h $HOME/.config/compton.conf || ln -sf $PWD/_compton.conf $HOME/.config/compton.conf
# test -h $HOME/.vim || ln -sf $PWD/vim $HOME/.vim
# test -h $HOME/.vimrc || ln -sf $PWD/vim/.vimrc $HOME/.vimrc
# mkdir -p $HOME/.config
# test -h $HOME/.vim || ln -sf $PWD/vim $HOME/.config/nvim
# mkdir -p ~/.config/nvim
# test -h $HOME/.config/nvim/init.vim || ln -sf $HOME/.vimrc $HOME/.config/nvim/init.vim
test -h $HOME/.config/nvim || ln -sf $PWD/nvim $HOME/.config/nvim
test -h $HOME/.config/ghostty || ln -sf $PWD/ghostty/ $HOME/.config/ghostty

git submodule sync
git submodule init
git submodule update
# git submodule foreach git pull origin master

git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
