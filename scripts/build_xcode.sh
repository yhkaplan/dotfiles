#!/bin/bash

osascript -e 'tell application "Xcode"
    activate

    set targetProject to active workspace document
    if (build targetProject) is equal to "Build succeeded" then
        launch targetProject
    end if
end tell'
