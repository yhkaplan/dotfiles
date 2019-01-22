#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

#make Finder show list of files by default instead of icons
# To add

# Make battery indicator show percent remaining
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# Make safari open tabs last opened

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

#Show date in menu bar alongside time
# To add

# Always open everything in Finder's list view.
defaults write com.apple.Finder FXPreferredViewStyle clmv

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

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
