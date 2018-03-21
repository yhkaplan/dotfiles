" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) 
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" Swift syntax highlighting
Plug 'https://github.com/keith/swift.vim.git'
" Nerdtree (file directory browser)
Plug 'https://github.com/scrooloose/nerdtree.git'
" Bracket and quote completion
Plug 'https://github.com/tpope/vim-surround.git'
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
" Better markdown support 
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" FZF (through Homebrew)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Airline status bar below
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ALE Linting for Go, Swift, etc
Plug 'w0rp/ale'

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
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

" ###### MARKDOWN SETTINGS #############

let g:vim_markdown_folding_disabled = 1
set conceallevel=2
autocmd FileType markdown setlocal indentexpr=
autocmd FileType markdown setlocal ts=4 sw=4 sts=0 expandtab " probably unneeded

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

" ########## Shortcut SETTINGS ###########
" TODO: probably don't need silent for all these
" Set default mapleader (Leader) to spacebar
let mapleader = "\<Space>"

nnoremap <silent> <leader>v :vsplit<CR>
nnoremap <silent> <leader>tn :tabnew<CR>
"tab next
nnoremap <silent> <leader>t :tabn<CR> 
" Sane defaults for split switching
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h 
nnoremap <leader>l <C-w>l

nnoremap <silent> <leader>n :NERDTreeToggle<CR>
" d for diff
nnoremap <silent> <leader>d :GitGutterToggle<CR>
nnoremap <silent> <leader>s :FZF<CR>
" s for search
" Setting this to begin with space f because I mostly plan on 
" using it to find functions
nnoremap <silent> <leader>f :BTags<CR> 
" gl for git log
nnoremap <silent> <leader>gl :Commits<CR>
" c for commands
nnoremap <silent> <leader>c :History:<CR>
nnoremap <silent> <leader>b :Buffers<CR>

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gb <Plug>(go-build)
au FileType go nmap <Leader>gt <Plug>(go-test)

" ########## GENERAL SETTINGS ###########
" Make nerdtree show hidden files by default
let NERDTreeShowHidden=1
" Line numbers
set number
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Turn off GitGutter by default
" Enable w/ :GitGutterToggle
let g:gitgutter_enabled = 0
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
" Fixes cursor 
set guicursor=

" ########### Proper tabs ###############
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" ########### ALE SETTINGS ###############
" Error and warning signs.
"let g:ale_sign_error = '⤫'
"let g:ale_sign_warning = '-'

" ########## AIRLINE SETTINGS ###########

let g:airline#extensions#branch#enabled = 1
" Enables powerline for airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#show_message = 0

" ############ Swift Settings ###############

" Makes sure Swift files are recognized as such
autocmd BufNewFile,BufRead *.swift set filetype=swift

" ############ Golang Settings ##############

let g:ale_linters = {'go': ['gofmt', 'gotype', 'govet']}

" ############ AUTOCOMPLETE #################

" Enable Deoplete
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 2

" Swift settings
" Jump to the first placeholder by typing `<C-k>`.
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
let g:deoplete#sources#swift#source_kitten_binary = '/usr/local/bin/sourcekitten'
let g:deoplete#sources#swift#daemon_autostart = 1

" Golang deoplete settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode' " May be incorrect
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" ######## Tag Support w/ FZF ########

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()
