#!/bin/bash

declare -a apps=( "Slack" "iTerm" "Things" "iCal" )

for app in "${apps[@]}"
do
  open -a "$app"
done
