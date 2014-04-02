#!/bin/bash
#
# Sets a new system up with correct configs and dependencies.
#
#

REPOURL=https://github.com/o4dev/dotfiles.git
DOTFILES=$HOME/.dotfiles

set -e

echo 'Installing dependencies...'
# Assume debian based and install dependencies
sudo apt-get install git zsh vim i3 xfce4-terminal conky tmux xfonts-terminus luakit

# Clone oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

echo 'Downloading configs....'
# Assuming script is not being run inside repo, clone repo.
git clone $REPOURL $DOTFILES



echo 'Setting up configs...'

# Simple backup function.
# Just moves existing configs to ~/.dotfiles.orig
backup(){
    if [ -f $HOME/$1 ]; then
        echo "Backing up $HOME/$1 to $DOTFILES.orig/$1 ...."
        mkdir -p $DOTFILES.orig
        mv $HOME/$1 $DOTFILES.orig
    fi
}


# Create a symbolic link for the standard configs
configs=(.zshrc .vimrc .conkyrc .tmux.conf .i3status.conf .mpdconf .i3 .ncmpcpp)
for config in $configs; do
    backup $config
    ln -s $DOTFILES/$config $HOME/$config
done


# Add modded oh-my-zsh theme
ln -s $DOTFILES/af-magic-mod.zsh-theme $HOME/.oh-my-zsh/themes


# Setup vim plugins etc
backup .vim
cp -r $DOTFILES/.vim $HOME/.vim

# GTK Setup

# Link the theme
mkdir -p $HOME/.themes
backup .themes/OMG-Dark
ln -s $DOTFILES/.themes/OMG-Dark $HOME/.themes

# Link gtk 2 config
backup .gtk-2.0
ln -s $DOTFILES/.gtkrc-2.0 $HOME

# Link gtk 3 config
mkdir -p $HOME/.config/gtk-3.0
backup .config/gtk-3.0/settings.ini
ln -s $DOTFILES/gtk-3.0-settings.ini $HOME/.config/gtk-3.0/settings.ini

# Xfce4-terminal setup
mkdir -p $HOME/.config/xfce4/terminal
backup $HOME/.config/xfce4/terminal/terminalrc
ln -s $DOTFILES/terminalrc  $HOME/.config/xfce4/terminal

# Use zsh as default shell
chsh -s /bin/zsh


