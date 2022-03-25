Those are my config files. I hope they are useful for someone but don't come crying if something breaks on your system because of them

# Installing on a new machine

    git clone git@github.com:nikolavp/configs.git
    cd config && ./install.sh


# Setting up the configuration
Note that some things require particular version of software to be presented(vim, awesome). Awesome there are some programs that are not installed by default but are required from different files like *.xinitrc*


### Dvorak
I am using dvorak and because I am from Bulgaria, I needed a dvorak mapping for my language. You can install it with the following on Linux

    cat bg-dvorak-phonetic >> /usr/share/X11/xkb/symbols/bg

On Macos, you need to copy the layout files

    cp dvorak-macos/* ~/Library/Keyboard\ Layouts/

# Newer version of vim needed
One of the plugins(YouCompleteMe) in the vim configuration needs a newer version of vim(at least from the one distributed with Ubuntu). Here is how to get a newer package:

    sudo add-apt-repository ppa:nmi/vim-snapshots
    sudo apt-get update

# Newer version of awesome needed
My awesome config files are compatible with awesome 3.5. If your distribution doesn't have this version of awesome you will have to find how to update it. I am currently using archlinux and ubuntu on different machines. Awesome 3.5 is in the archlinux repos so there is no additionals steps for it but if you happen to be on ubuntu here is what has to be done:

    sudo add-apt-repository ppa:klaus-vormweg/awesome
    sudo apt-get update

# Required software

Software that is needed can be required with the following on an Ubuntu system

    sudo apt-get install -y subversion vim-gtk awesome awesome-extra zsh tmux gtk-redshift xscreensaver xscreensaver-data-extra xscreensaver-gl-extra parcellite xbindkeys links compton devmon kbdd jq


# Personal stuff that you may or may not use

    sudo apt-get install keepassx mpd mplayer mutt-patched weechat-curses imapfilter

Other thigs:

* Integration for keepassx with firefox browser https://addons.mozilla.org/en-US/firefox/addon/hostname-in-titlebar/
* Install skype from their site
* Install taskn for tasknotes in taskwarrior 
* Install git-standup from https://github.com/kamranahmedse/git-standup
```
sudo pip install taskn
```
* On ubuntu only
```
sudo apt-get install consolekit ubuntu-restricted-extras
```
* Install dropboxd from their site
* Install oh-my-zshell https://github.com/robbyrussell/oh-my-zsh and chsh to /bin/zsh

# Journaling
I keep a journal, do you? I found jrnl to be exactly what I want :)
```
sudo pip install jrnl
```

# Presentation
I use dspdfviewer with pdfs built with beamer + latex

```
sudo add-apt-repository ppa:dannyedel/dspdfviewer
sudo apt-get update
sudo apt-get install dspdfviewer
```


# Beets setup

```
sudo apt-get install python-dev python-pip libyaml-dev
sudo pip install beets
```

# Karabiner setup

On MacOS I am remapping the caps lock to esc and using it as a functional modifier key when pressed. Also I am remapping fn+htcn for the dvorak arrow keys. You can look into karabiner directory which contains complex modification assets for the above.

# MacOS setup

brew install --cask karabiner-elements
brew install --cask hammerspoon
brew install autojump nvim direnv fzf blueutil bat

