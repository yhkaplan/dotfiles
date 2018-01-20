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

" Go-lang completion (erroring out....)
"Plug 'zchee/deoplete-go', { 'do': 'make'}

" FZF (through Homebrew)
Plug '/usr/local/opt/fzf'

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

" Line numbers
set number

" Enables powerline for airline
let g:airline_powerline_fonts = 1

" Enable CursorLine
set cursorline

" Default Colors for CursorLine
highlight  CursorLine ctermbg=White ctermfg=Black

" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=Black ctermfg=None

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=White ctermfg=Black

"let g:airline_theme='minimalist'
let g:gotham_airline_emphasised_insert = 0

" Turns off annoying behavior of auto-inserting comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Show matching brackets
set showmatch

" Enable Neoplete
let g:deoplete#enable_at_startup = 1

" Xcode style tabs
set expandtab
"set tabstop=4 "not working correctly doubled?

" Fixes cursor 
set guicursor=
