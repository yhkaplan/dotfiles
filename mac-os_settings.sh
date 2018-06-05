#!/bin/bash

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

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show Safari's bookmark bar.
defaults write com.apple.Safari ShowFavoritesBar -bool true

#  Edit > Preferences, click Devices, then select “Prevent iPods, iPhones, and iPads from syncing automatically.”

# Put dock on the left
defaults write com.apple.dock orientation -string left

###############################################################################
# Xcode                                                                       #
###############################################################################

# Display build times
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

