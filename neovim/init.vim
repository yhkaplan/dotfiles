" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) 
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" General syntax highlighting
Plug 'https://github.com/vim-syntastic/syntastic.git'

" Swift syntax highlighting
Plug 'https://github.com/keith/swift.vim.git'

" Nerdtree (file directory browser)
Plug 'https://github.com/scrooloose/nerdtree.git'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Swift completion
Plug 'mitsuse/autocomplete-swift'

" Airline status bar below
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Themes
Plug 'whatyouhide/vim-gotham'
Plug 'dracula/vim'

call plug#end()

" This is activated by default by syntastic
syntax on
color gotham

" Enable Neoplete
let g:deoplete#enable_at_startup = 1

" Xcode style tabs
set tabstop=4

" Fixes cursor 
set guicursor=
