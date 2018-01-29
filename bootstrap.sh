#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

echo "Installing packages..."

# Select directory and run brewfile
# The Brewfile is generated automatically through 'brew bundle dump'
cd ~/.dotfiles/
brew bundle
brew cleanup
brew cask cleanup

# Setting for RBENV/Ruby
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra echo "Cleaning up..."

# Dependencies for Deoplete on other Pythonic stuff
pip3 install -r pip-requirements.txt

# 3 good git aliases
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 --stat HEAD'
git config --global alias.shortlog 'log -4 --pretty --oneline'

# We installed the new shells, now we have to activate them
echo "Adding newly installed shells to the list of allowed shells and making fish the default"

# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
sudo bash -c 'echo /usr/local/bin/fish >> /etc/shells'

echo "Setting up Fish"

# Make Fish the default shell
chsh -s /usr/local/bin/fish

# Open fish and install useful utilities/themes
fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher omf/theme-edan

fish_update_completions

echo "Bootstrapping complete"
