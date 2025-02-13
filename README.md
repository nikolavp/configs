Those are my config files. I hope they are useful for someone but don't come crying if something breaks on your system because of them

# Installing on a new machine

    git clone git@github.com:nikolavp/configs.git
    cd config && ./install.sh


# Tools:

* Install git-standup from https://github.com/kamranahmedse/git-standup

# Presentation
I use dspdfviewer with pdfs built with beamer + latex

```
sudo add-apt-repository ppa:dannyedel/dspdfviewer
sudo apt-get update
sudo apt-get install dspdfviewer
```

# Linux setup

Software that is needed can be required with the following on an Ubuntu system

    sudo apt-get install -y subversion vim-gtk awesome awesome-extra zsh tmux gtk-redshift xscreensaver xscreensaver-data-extra xscreensaver-gl-extra parcellite xbindkeys links compton devmon kbdd jq


### Dvorak
I am using dvorak and because I am from Bulgaria, I needed a dvorak mapping for my language. You can install it with the following on Linux

    cat bg-dvorak-phonetic >> /usr/share/X11/xkb/symbols/bg

# MacOS setup

    brew install --cask karabiner-elements
    brew install --cask hammerspoon
    brew install autojump nvim direnv fzf blueutil bat glow docker-credential-helper-ecr delta

https://loshadki.app/
https://github.com/Schniz/fnm - faster nvm alternative
https://github.com/awslabs/amazon-ecr-credential-helper

Give access to bluetooth for hammerspoon: Go to Settings -> Privacy & Security -> Bluetooth and add hammerspoon. This allows it to use blueutil to disable/enable bluetooth when the lid is closed.

## Karabiner setup

On MacOS I am remapping the caps lock to esc and using it as a functional modifier key when pressed. Also I am remapping fn+htcn for the dvorak arrow keys. You can look into karabiner directory which contains complex modification assets for the above.


## Dvorak

You need to copy the layout files

    cp dvorak-macos/* ~/Library/Keyboard\ Layouts/
