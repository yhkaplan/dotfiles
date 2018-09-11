#!/bin/bash

# grab dracula and gotham themes for xcode, vim, terminal, and atom
mkdir -p ~/Downloads/themes
cd ~/Downloads/themes/

git clone --depth 1 'https://github.com/imcatnoone/toothpaste.git'

git clone --depth 1 'https://github.com/whatyouhide/vim-gotham.git'
git clone --depth 1 'https://github.com/whatyouhide/gotham-contrib.git'

git clone --depth 1 'https://github.com/iest/Panic-Palette-Extras.git'

git clone --depth 1 'https://github.com/cocopon/iceberg.vim.git'
git clone --depth 1 'https://github.com/cocopon/xcode-iceberg.git'
git clone --depth 1 'https://github.com/aseom/dotfiles/blob/master/osx/iterm2/iceberg.itermcolors'

git clone --depth 1 'https://github.com/bojan/xcode-one-dark.git'
git clone --depth 1 'https://github.com/sonph/onehalf.git'
git clone --depth 1 'https://github.com/nathanbuchar/atom-one-dark-terminal.git'

git clone --depth 1 'https://github.com/dracula/alfred'
git clone --depth 1 'https://github.com/dracula/vim.git'
git clone --depth 1 'https://github.com/dracula/terminal.app.git'
git clone --depth 1 'https://github.com/dracula/iterm.git'
git clone --depth 1 'https://github.com/dracula/xcode.git'
