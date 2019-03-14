#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#make Finder show list of files by default instead of icons
# To add

# Show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Make battery indicator show percent remaining
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

#Show date in menu bar alongside time
# To add

# Always open everything in Finder's list view.
defaults write com.apple.Finder FXPreferredViewStyle clmv

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show all filename extensions and hidden files
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles TRUE

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show Safari's bookmark bar.
defaults write com.apple.Safari ShowFavoritesBar -bool true

#  Edit > Preferences, click Devices, then select “Prevent iPods, iPhones, and iPads from syncing automatically.”

# Put dock on the left
defaults write com.apple.dock orientation -string left

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
# defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write NSGlobalDomain InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)

###############################################################################
# Xcode                                                                       #
###############################################################################

# Display build times
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

# Add iOS Simulator to Launchpad
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"

###############################################################################
# Spectacle.app                                                               #
###############################################################################

# Set up my preferred keyboard shortcuts
# cp -r init/spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json 2> /dev/null

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
  "Calendar" \
  "cfprefsd" \
  "Dock" \
  "Finder" \
  "Google Chrome" \
  "Spectacle" \
  "SystemUIServer" \
  "Xcode" \
  "iCal"; do
  killall "${app}" &>/dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
