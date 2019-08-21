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

brew install mas # Install Mac App Store Homebrew integration

# If no CLI tools, then install
if test ! "$(command -v gcc)"; then
  sudo xcode-select --install
  sudo xcodebuild -license accept
fi

# If no xcode, then install
if ! [ -d "/Applications/Xcode.app" ]; then
  mas install 497799835 # Xcode ID
  if ! [ -d "/Applications/Xcode.app" ]; then
    echo "No Xcode installed"; exit 1
  fi
fi

# If no ansible, then install
if test ! "$(command -v ansible)"; then
  brew install ansible
fi

# Ansible
ansible-playbook ansible/main_playbook.yml --ask-become-pass

# TODO: Move the below, then xcode stuff to ansible playbooks

# Select directory and run brewfile
# The Brewfile is generated automatically through 'brew bundle dump'
mv ~/dotfiles ~/.dotfiles
cd ~/.dotfiles/ || { echo "Could not cd dotfiles"; exit 1; }

while true; do
  read -r -p "Do you want to install brew packages? " yn
  case $yn in
  [Yy]*)
    brew update
    brew upgrade

    echo "Installing packages..."

    brew bundle
    brew cleanup
    break
    ;;
  [Nn]*)
    echo "Skipping brew packages"
    break
    ;;
  *) echo "Please input yes or no" ;;
  esac
done

############ LLDB ###############
mkdir -p ~/.lldb
(cd ~/.lldb && git clone git@github.com:DerekSelander/LLDB.git)

############ Ruby ###############

# Setting for RBENV/Ruby
echo "Setting up Ruby. Please make sure to check that the version of bundler matches the version installed by rbenv"
eval "$(rbenv init -)"

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

# Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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
# amend w/ previous commit name
git config --global alias.amend 'commit --amend --no-edit'

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
