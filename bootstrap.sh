#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

echo "Starting bootstrapping"

############ Homebrew ###############

# Check for Homebrew, install if we don't have it
if test ! "$(command -v brew)"; then
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
cd ~/.dotfiles/ || echo "Could not cd dotfiles"
exit 1
brew bundle
brew cleanup
brew cask cleanup

############ Ruby ###############

# Setting for RBENV/Ruby
echo "Setting up Ruby. Please make sure to check that the version of bundler matches the version installed by rbenv"

LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" echo "Cleaning up..." >>~/.extra

echo "Installing Ruby versions"
rbenv install 2.5.1
rbenv install 2.6.0

# Installs bundler for system version of Ruby, may cause
# headaches and issues if the rbenv version doesn't have bundler installed
# XCPretty required for vim-xcode and nice for running xcodebuild in command line
sudo gem install bundler xcpretty

########## Other ################

# Zsh plugins
antibody bundle <~/.dotfiles/zsh/.zsh_plugins.txt >~/.zsh_plugins.sh

# Dependencies for Deoplete on other Pythonic stuff
pip3 install -r pip-requirements.txt

# Golang dependencies
python3 go/install.py

# JS
npm install -g prettier
npm install -g remark-lint

# Make iTerm/Terminal "Last login:" message from Login utility stop appearing
touch ~/.hushlogin

# Git aliases
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 --stat HEAD'
git config --global alias.shortlog 'log -4 --pretty --oneline'
git config --global alias.current 'rev-parse --abbrev-ref HEAD'
git config --global core.excludesfile ~/.gitignore_global

# Set GHQ
git config --global ghq.root ~/dev

echo "Setting symlinks"
python3 make_symlinks.py

echo "Please update hosts file with contents of https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"

# We installed the new shells, now we have to activate them
echo "Adding newly installed shells to the list of allowed shells"

# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'

# Gives user choice for preferred shell
while true; do
    read -r -p "Do you want Zsh to be your default shell? " yn
    case $yn in
    [Yy]*)
        chsh -s /usr/local/bin/zsh
        echo "Bootstrapping complete"
        zsh
        break
        ;;
    [Nn]*)
        echo "Bootstrapping complete"
        exit
        ;;
    *) echo "Please input yes or no" ;;
    esac
done
