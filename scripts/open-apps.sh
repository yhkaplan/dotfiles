#!/bin/bash

declare -a apps=("Slack" "iTerm" "Things3" "iCal")

for app in "${apps[@]}"; do
  open -a "$app"
done
