#!/bin/bash

# NeoVim file (contains autoinstall script)
ln -sv ~/.dotfiles/neovim/init.vim ~/.config/nvim/

# Tmux 
ln -sv ~/.dotfiles/tmux/.tmux.conf ~/

# Fish 
ln -sv ~/.dotfiles/fish/config.fish ~/.config/fish/
ln -sv ~/.dotfiles/fish/fish_prompt.fish ~/.config/fish/functions/

# Bash
ln -sv ~/.dotfiles/bash/.bash_profile ~/

# Gem
ln -sv ~/.dotfiles/gem/Gemfile ~/
# Add Gemfile.lock??

# Gitignore (optimized for iOS development)
ln -sv ~/.dotfiles/git/.gitignore ~/

# Themes
ln -sv ~/.dotfiles/themes/gotham/gotham.sh ~/.config/gotham/
