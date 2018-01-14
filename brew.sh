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
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash

brew install bash-completion
brew install homebrew/completions/brew-cask-completion

# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash
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
    terminal-notifier
    python
    neovim
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

# Remove outdated versions from the cellar
brew cleanup

echo "Bootstrapping complete"
