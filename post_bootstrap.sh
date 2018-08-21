#!/usr/local/bin/fish

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher install tuvistavie/fish-ssh-agent
fisher install fzf
fisher install eden
