#!/bin/bash

OLD_FILE_PATH="$HOME/.old_dotfiles"
SYMLINKS_FILE="$HOME/.dotfiles/symlinks.txt"

mkdir -p "$OLD_FILE_PATH"

while IFS= read -r line; do
    source=$(echo "$line" | awk '{print $1}' | sed "s|~|$HOME|g")
    target=$(echo "$line" | awk '{print $2}' | sed "s|~|$HOME|g")

    file_pattern='([\w|\.]+)\s'
    if [[ "$line" =~ $file_pattern ]]; then
        existing_file_path="$target${BASH_REMATCH[1]}"
        echo "Moving $existing_file_path to $OLD_FILE_PATH"
        mv "$existing_file_path" "$OLD_FILE_PATH/"
    fi

    if [[ "$target" != "$HOME/" && "$target" != "$HOME" ]]; then
        echo "Making folders for $target"
        mkdir -p "$target"
    fi

    echo "Symlinking $source to $target"
    ln -sfv "$source" "$target"
done < "$SYMLINKS_FILE"