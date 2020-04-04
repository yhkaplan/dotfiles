#!/usr/bin/env bash
set -ex

tags="$1"

if [ -z $tags ]; then
  tags="all"
fi

if ! [ -x "$(ansible -v ansible)" ]; then
  sudo apt-get install ansible
fi

ansible-playbook \
  -i ~/.dotfiles/hosts \
  ~/.dotfiles/dotfiles.yml \
  --ask-become-pass \
  --tags $tags
