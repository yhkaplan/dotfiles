#!/bin/bash

##### Variables

old=~/.old_dotfiles

##### Script

echo "Backing up existing dotfiles"

mkdir -p $old

mv ~/.config/nvim/init.vim ~/.old_dotfiles/
mv ~/.tmux.conf ~/.old_dotfiles/
mv ~/.config/fish/config.fish ~/.old_dotfiles/
mv ~/.bash_profile ~/.old_dotfiles/
mv ~/Gemfile ~/.old_dotfiles/
mv ~/.gitignore ~/.old_dotfiles/
mv ~/.config/gotham/gotham.sh ~/.old_dotfiles/

echo "Generating symlinks"

# NeoVim file (contains autoinstall script)
mkdir -p ~/.config/nvim
ln -sv ~/.dotfiles/neovim/init.vim ~/.config/nvim/

# Tmux 
ln -sv ~/.dotfiles/tmux/.tmux.conf ~/

# Fish 
ln -sv ~/.dotfiles/fish/config.fish ~/.config/fish/

# Bash
ln -sv ~/.dotfiles/bash/.bash_profile ~/

# Gem
ln -sv ~/.dotfiles/gem/Gemfile ~/
# Add Gemfile.lock??

# Gitignore (optimized for iOS development)
ln -sv ~/.dotfiles/git/.gitignore ~/

# Themes
mkdir -p ~/.config/gotham
ln -sv ~/.dotfiles/themes/gotham/gotham.sh ~/.config/gotham/

mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/colors
ln -sv ~/.dotfiles/themes/toothpaste.vim ~/.config/nvim/colors/
