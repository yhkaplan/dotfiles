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

# Install command-line tools using Homebrew
# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names

# Bash 4
brew install bash

brew install bash-completion
brew install homebrew/completions/brew-cask-completion

# Install `wget` with IRI support.
brew install wget --with-iri

# Install ruby-build and rbenv
brew install ruby-build
brew install rbenv
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

# Install more recent versions of some OS X tools
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
#brew install homebrew/dupes/openssh Messes with Mac ssh config...
brew install homebrew/dupes/screen

PACKAGES=(
    atom
    autoconf
    openssl
    carthage
    bash-completion
  	fzf
	fish
    pkg-config
    go
    git
    hub
	cloc
    ncdu # find where your diskspace went
    trash
    fastlane
    pv
    rename
    zopfli
    the_silver_searcher
    git
    mas
  	rbenv
    ruby-build
    swiftgen
    terminal-notifier
    tree
    tmux
    python
    neovim
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

# We installed the new shells, now we have to activate them
echo "Adding newly installed shells to the list of allowed shells and making fish the default"

# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
sudo bash -c 'echo /usr/local/bin/fish >> /etc/shells'

# Make Fish the default shell
chsh -s /usr/local/bin/fish

echo "Bootstrapping complete"
