#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Starting bootstrapping"

############ Homebrew ###############

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
mv ~/dotfiles ~/.dotfiles
cd ~/.dotfiles/
brew bundle
brew cleanup
brew cask cleanup

############ Ruby ###############

# Setting for RBENV/Ruby
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra echo "Cleaning up..."

sudo gem install bundler

########## Other ################

# Dependencies for Deoplete on other Pythonic stuff
pip3 install -r pip-requirements.txt

# Make iTerm/Terminal "Last login:" message from Login utility stop appearing
touch ~/.hushlogin

# Git aliases
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 --stat HEAD'
git config --global alias.shortlog 'log -4 --pretty --oneline'
git config --global alias.current 'rev-parse --abbrev-ref HEAD'

# We installed the new shells, now we have to activate them
echo "Adding newly installed shells to the list of allowed shells"

# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
sudo bash -c 'echo /usr/local/bin/fish >> /etc/shells'

# Gives user choice for preferred shell

while true; do
    read -p "Do you want Fish to be your default shell? " yn
    case $yn in
        [Yy]* )
            chsh -s /usr/local/bin/fish
            # Open fish and install useful utilities/themes
        
            curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
            echo "Bootstrapping complete"
            fish
            break;;
        [Nn]* ) echo "Bootstrapping complete"; exit;;
        * ) echo "Please input yes or no";;
    esac 
done

