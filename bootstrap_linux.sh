#!/usr/bin/env bash
set -ex

tags="$1"

if [ -z $tags ]; then
  tags="all"
fi

if ! [ -x "$(ansible -v ansible)" ]; then
  sudo apt install ansible -v 2.9.6
fi

ansible-playbook \
  -i ~/.dotfiles/hosts \
  ~/.dotfiles.yml \
  --ask-become-pass \
  --tags $tags
