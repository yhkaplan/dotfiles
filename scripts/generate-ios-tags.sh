#!/bin/bash

# Referenced: https://colindrake.me/post/vim-for-ios-development-setting-up-ctags/

# GLOBAL_TAGS="$HOME/dev/global-tags"
GLOBAL_TAGS="$(pwd)/global_tags"

FOUNDATION_PATH=/System/Library/Frameworks/Foundation.framework/Headers
UIKIT_PATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.4.sdk/System/Library/Frameworks/UIKit.framework/Headers
#TODO: Add Swift stdlib

append_tags() {
  cd "$1" || exit 1
  /usr/local/bin/ctags ./*.h --languages=objectivec --langmap=objectivec:.h.m --append -f "$GLOBAL_TAGS"
}

# Delete tags if they already exist
if [ -f "$GLOBAL_TAGS" ]; then
  rm "$GLOBAL_TAGS"
fi

touch "$GLOBAL_TAGS"

append_tags "$FOUNDATION_PATH"
append_tags "$UIKIT_PATH"
