
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

#  Edit > Preferences, click Devices, then select “Prevent iPods, iPhones, and iPads from syncing automatically.”

# Put dock on the left
defaults write com.apple.dock orientation -string left
