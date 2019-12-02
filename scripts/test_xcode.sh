#!/usr/bin/env sh

osascript -e 'tell application "Xcode"
  activate

  set targetProject to active workspace document
  tell application "System Events"
      keystroke "u" using command down
  end tell
end tell

tell application "iTerm"
  activate
end tell
'
