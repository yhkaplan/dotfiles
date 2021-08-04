osascript <<EOF
  tell application "Xcode" to activate
  tell application "System Events"
    keystroke "8" using command down -- Show all breakpoints
    keystroke "a" using command down -- Select all breakpoints
    keystroke (ASCII character 127) -- Delete with backspace key
  end tell

  tell application "iTerm" to activate
EOF
