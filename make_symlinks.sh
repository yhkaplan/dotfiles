#!/bin/bash

# NeoVim file (contains autoinstall script)
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

# Fastlane

