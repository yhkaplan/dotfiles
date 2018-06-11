#!/usr/bin/osascript
on run argv
  tell application "iTerm2"
    create window with default profile
    tell current session of current window
      write text "nvim " & item 1 of argv
    end tell
  end tell
end run
