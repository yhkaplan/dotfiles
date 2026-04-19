#!/usr/bin/env bash
# macOS system preferences. Safe to re-run. Pass --restart-apps to kill
# affected apps so changes take effect immediately (disruptive — off by default).

set -Eeuo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "macOS only — skipping"
    exit 0
fi

RESTART_APPS=0
for arg in "$@"; do
    case "$arg" in
    --restart-apps) RESTART_APPS=1 ;;
    -h | --help)
        cat <<EOF
Usage: $(basename "$0") [--restart-apps]
  --restart-apps   Kill affected apps (Finder, Dock, etc) after applying settings
EOF
        exit 0
        ;;
    *)
        echo "unknown flag: $arg" >&2
        exit 1
        ;;
    esac
done

# Close any open System Preferences panes so they don't overwrite our settings.
osascript -e 'tell application "System Preferences" to quit' >/dev/null 2>&1 || true

sudo -v

SUDO_PID=""
cleanup() {
    [[ -n "$SUDO_PID" ]] && kill "$SUDO_PID" 2>/dev/null || true
}
trap cleanup EXIT

(
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" 2>/dev/null || exit
    done
) 2>/dev/null &
SUDO_PID=$!

# Show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Menu bar: battery percent + date alongside time
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm a"

# Dock: don't show recent apps
defaults write com.apple.dock show-recents -bool false

# Finder: list view, path bar, all extensions, hidden files
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true

# Dashboard: disabled, not shown as a space
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock dashboard-in-overlay -bool true

# App Store: auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Don't sprinkle .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Keyboard: disable press-and-hold, fast initial key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain InitialKeyRepeat -int 10

###############################################################################
# Xcode                                                                       #
###############################################################################

defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true

if [[ -d /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app ]]; then
    if [[ ! -e /Applications/Simulator.app ]]; then
        sudo ln -s "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" \
            "/Applications/Simulator.app"
    fi
else
    echo "Xcode not installed — skipping Simulator symlink"
fi

###############################################################################
# Apply changes                                                               #
###############################################################################

if (( RESTART_APPS )); then
    echo "Restarting affected apps..."
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
        killall "$app" &>/dev/null || true
    done
else
    echo "Done. Some changes require logout/restart or an app relaunch to take effect."
    echo "Re-run with --restart-apps to kill affected apps now."
fi
