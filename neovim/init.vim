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
" GitHub integration w/ above
Plug 'https://github.com/tpope/vim-rhubarb.git'

" Git diff integration
Plug 'airblade/vim-gitgutter'

" Swift completion (not clear if it's working)
Plug 'mitsuse/autocomplete-swift'

" Python autocomplete
Plug 'zchee/deoplete-jedi'

" Go-lang completion (erroring out....)
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go' " May conflict w/ deoplete-go

" FZF (through Homebrew)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Airline status bar below
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Themes
Plug 'whatyouhide/vim-gotham'
Plug 'https://github.com/rakr/vim-one.git'
Plug 'dracula/vim'
Plug 'iCyMind/NeoSolarized'
Plug 'nightsense/vimspectr'
Plug 'mhartington/oceanic-next'

call plug#end()

" ############ TMUX COLOR SUPPORT #################

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

" ############ THEMING #################

set background=dark " for the dark version
colorscheme one
let g:airline_theme='one'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ########## GENERAL SETTINGS ###########

" Line numbers
set number

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Turn off GitGutter by default
" Enable w/ :GitGutterToggle
let g:gitgutter_enabled = 0

" ########## AIRLINE SETTINGS ###########

let g:airline#extensions#branch#enabled = 1

" Enables powerline for airline
let g:airline_powerline_fonts = 1
"let g:airline#extensions#syntastic#enabled = 0 "Disables syntastic integration
let g:airline#extensions#syntastic#error_symbol = 'E:'
let g:airline#extensions#syntastic#warning_symbol = 'W:'

let g:airline#extensions#whitespace#show_message = 0
"let g:airline_section_error = '%-0.10{getcwd()}'
"let g:airline_section_warning = '%t'
" Enable CursorLine
set cursorline

" Default Colors for CursorLine
highlight  CursorLine ctermbg=White ctermfg=Black

" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=Black ctermfg=None

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=White ctermfg=Black

" Turns off annoying behavior of auto-inserting comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Show matching brackets
set showmatch

" Use macOS pasteboard
set clipboard=unnamed

" Makes sure Swift files are recognized as such
autocmd BufNewFile,BufRead *.swift set filetype=swift

" Xcode style tabs
setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" Fixes cursor 
set guicursor=

" ############ AUTOCOMPLETE #################

" Enable Deoplete
let g:deoplete#enable_at_startup = 1

" Golang deoplete settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode' " May be incorrect
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" To prevent VimGo from conflicting w/ syntastic
let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter']
let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Another issue with `vim-go` and `syntastic` is that the location list window
" that contains the output of commands such as `:GoBuild` and `:GoTest` might
" not appear.  To resolve this:
let g:go_list_type = "quickfix"

