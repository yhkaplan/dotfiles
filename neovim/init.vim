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

" Git integration
Plug 'https://github.com/tpope/vim-fugitive.git'

" Git diff integration
Plug 'airblade/vim-gitgutter'

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
Plug 'https://github.com/rakr/vim-one.git'
Plug 'dracula/vim'

call plug#end()

" This is activated by default by syntastic
"syntax on

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" color toothpaste
set background=dark " for the dark version
colorscheme one
let g:airline_theme='one'

" Line numbers
set number

" Enables powerline for airline
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_y = '%-0.10{getcwd()}'
" Enable CursorLine
set cursorline

" Default Colors for CursorLine
highlight  CursorLine ctermbg=White ctermfg=Black

" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=Black ctermfg=None

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=White ctermfg=Black

"let g:airline_theme='minimalist'
"let g:gotham_airline_emphasised_insert = 0

" Turns off annoying behavior of auto-inserting comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Show matching brackets
set showmatch

" Enable Neoplete
let g:deoplete#enable_at_startup = 1

" Xcode style tabs
"set expandtab
"set tabstop=4 "not working correctly doubled?

" Fixes cursor 
set guicursor=
