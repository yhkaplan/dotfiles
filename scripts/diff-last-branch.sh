#!/bin/bash

current_branch=$(git branch | grep "\\*" | cut -d ' ' -f2)
current_branch_number=${current_branch: -1}
numberless_branch=$(echo "$current_branch" | rev | cut -c 2- | rev)

previous_number=$((current_branch_number - 1))
previous_branch="$numberless_branch$previous_number"

git diff "$previous_branch"
