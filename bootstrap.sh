#!/usr/bin/env sh

BREW="/opt/homebrew/bin/brew"

#### Main ####

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "Starting bootstrapping"
set -ex

############ Homebrew ###############

# Check for Homebrew, install if we don't have it
if test ! "$(command -v $BREW)"; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# If no CLI tools, then install
if test ! "$(command -v gcc)"; then
  echo "Install Xcode!"
  exit 1
fi

# Select directory and run brewfile
# The Brewfile is generated automatically through 'brew bundle dump'
cd ~/.dotfiles/ || { echo "Could not cd dotfiles"; exit 1; }

while true; do
  read -r -p "Do you want to install brew packages? " yn
  case $yn in
  [Yy]*)
    $BREW update
    $BREW upgrade

    echo "Installing packages..."

    $BREW bundle
    $BREW cleanup
    break
    ;;
  [Nn]*)
    echo "Skipping brew packages"
    break
    ;;
  *) echo "Please input yes or no" ;;
  esac
done

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

############ LLDB ###############
if [ -d "~/.lldb" ]; then
  mkdir -p ~/.lldb
  (cd ~/.lldb && git clone git@github.com:DerekSelander/LLDB.git)
fi

########## Other ################

# Zsh plugins
antibody bundle <~/.dotfiles/zsh/.zsh_plugins.txt >~/.zsh_plugins.sh

# Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Make iTerm/Terminal "Last login:" message from Login utility stop appearing
touch ~/.hushlogin

# Git aliases
# amend w/ previous commit name
git config --global alias.amend 'commit --amend --no-edit'

git config --global init.defaultBranch main
git config --global core.excludesfile ~/.gitignore_global
git config --global pull.rebase false # pre 2.27.0 pull behavior w/o warning
git config --global --add --bool push.autoSetupRemote true # push w/o setting upstream manually

# Set pager to delta, a nice Rust differ
git config --global core.pager "delta --dark"

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
