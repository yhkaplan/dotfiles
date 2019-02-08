#!/bin/bash

osascript -e 'tell application "Xcode"
  activate

  set targetProject to active workspace document
  if (run targetProject) is equal to "Build succeeded" then
    launch targetProject
  end if
end tell

tell application "iTerm"
  activate
end tell
'
