#!/bin/bash

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher install tuvistavie/fish-ssh-agent
fisher install fzf
fisher install eden

# requires atom commandline tools
apm install --packages-file ~/.atom/package.list
