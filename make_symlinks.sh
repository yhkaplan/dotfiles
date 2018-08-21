#!/bin/bash

##### Variables

old=~/.old_dotfiles

##### Script

echo "Backing up existing dotfiles"

mkdir -p "$old"

mv ~/.config/nvim/init.vim ~/.old_dotfiles/
mv ~/.tmux.conf ~/.old_dotfiles/
mv ~/.config/fish/config.fish ~/.old_dotfiles/
mv ~/.bash_profile ~/.old_dotfiles/
mv ~/.bashrc ~/.old_dotfiles/
mv ~/Gemfile ~/.old_dotfiles/
mv ~/.gitignore ~/.old_dotfiles/
mv ~/.atom ~/.old_dotfiles/
mv ~/.config/yamllint/config ~/.old_dotfiles/

echo "Generating symlinks"

# yamllint config
mkdir -p ~/.config/yamllint/
ln -sv ~/.dotfiles/yaml/config ~/.config/yamllint/

# Ctags
ln -sv ~/.dotfiles/ctags/.ctags ~/

# NeoVim file (contains autoinstall script)
mkdir -p ~/.config/nvim
ln -sv ~/.dotfiles/neovim/init.vim ~/.config/nvim/

# Tmux
ln -sv ~/.dotfiles/tmux/.tmux.conf ~/

# Fish
ln -sv ~/.dotfiles/fish/config.fish ~/.config/fish/
mkdir -p ~/.config/fish/functions
ln -sv ~/.dotfiles/fish/git.fish ~/.config/fish/functions/

# Bash
ln -sv ~/.dotfiles/bash/.bash_profile ~/
ln -sv ~/.dotfiles/bash/.bashrc ~/

# Gem
ln -sv ~/.dotfiles/gem/Gemfile ~/
# Add Gemfile.lock??

# Atom
ln -sv ~/.dotfiles/atom/.atom ~/

# Gitignore (optimized for iOS and Go development on macOS)
ln -sv ~/.dotfiles/git/.gitignore_global ~/
git config --global core.excludesfile ~/.gitignore_global

