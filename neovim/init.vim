" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" Tags
Plug 'majutsushi/tagbar'
" Directory brower, replacement for netrw
Plug 'ap/vim-readdir'
" Running swift test, gotest, etc
Plug 'janko-m/vim-test'
" Xcodebuild, run, etc
Plug 'gfontenot/vim-xcode'
" Swift syntax highlighting
Plug 'keith/swift.vim'
" Bracket and quote completion
Plug 'Shougo/neopairs.vim'
Plug 'jiangmiao/auto-pairs'
" Surrounding with quote, bracket, etc
Plug 'tpope/vim-surround'
" Commenting out
Plug 'tpope/vim-commentary'
" Detect indent type etc
Plug 'tpope/vim-sleuth'
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Git integration
Plug 'tpope/vim-fugitive'
" Git diff integration
Plug 'airblade/vim-gitgutter'
" Swift completion (not clear if it's working)
Plug 'mitsuse/autocomplete-swift'
" Python autocomplete
Plug 'zchee/deoplete-jedi'
" Go-lang completion
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go'
" Better markdown support
Plug 'gabrielelana/vim-markdown'
" FZF (through Homebrew)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Airline status bar below
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
" ALE Linting for Go, Swift, etc
Plug 'w0rp/ale'

" Theme(s)
Plug 'rakr/vim-one'

call plug#end()

" ############ TMUX COLOR SUPPORT #################

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has('nvim'))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has('termguicolors'))
  set termguicolors
endif

" ############ THEMING #################

set background=dark " for the dark version
colorscheme one

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

nnoremap <silent> <leader>v :vsplit<CR><C-w>l
nnoremap <silent> <leader>H :split<CR><C-w>j
nnoremap <silent> <leader>tn :tabnew<CR>
" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Sane defaults for split switching
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" s for search
nnoremap <silent> <leader>s :FZF<CR>
" gl for git log
nnoremap <silent> <leader>gl :Commits<CR>
" c for commands
nnoremap <silent> <leader>c :History:<CR>
" r for recent
nnoremap <silent> <leader>r :Hist<CR>
nnoremap <silent> <leader>B :Buffers<CR>
" K for Keybindings
nnoremap <silent> <leader>K :Maps<CR>
" L for git Log
nnoremap <silent> <leader>L :Commits<CR>

" Setting this to begin with space f because I mostly plan on
" using it to find functions
nnoremap <silent> <leader>f :TagbarToggle<CR>
" Pastes buffer into newline below
nnoremap  <silent> <leader>p :pu<CR>
" Pastes buffer into newline above
nnoremap  <silent> <leader>P :pu!<CR>
" Splits line at cursor (u for unjoin)
nnoremap <silent> <leader>u :<C-u>call BreakHere()<CR>
" Yank to end of line
nnoremap <silent> <leader>y yg_
" Pastes at end
nnoremap <silent> <leader>a $p
" Map vim-commentary to IDE-like mapping
nnoremap <silent> <leader>/ :Commentary<CR>
vnoremap <silent> <leader>/ :Commentary<CR>
" Insert newline below
nnoremap <silent> <leader>o o<Esc>k
" Insert newline above
nnoremap <silent> <leader>O O<Esc>j
" Insert space after
nnoremap <silent> <leader>i i<space><esc>
" Insert space before
nnoremap <silent> <leader>I hi<space><esc>
" Find and replace word
nnoremap <silent> <leader>R :%s/\<<C-r><C-w>\>//g<left><left>

" vim-fugitive/git
" ga for git add
nnoremap <silent> <leader>ga :Gwrite<CR>
" gc git commit
nnoremap <silent> <leader>gc :Gcommit<CR>
" gp git push
nnoremap <silent> <leader>gp :Gpush<CR>
" gd git diff
nnoremap <silent> <leader>gd :GitGutterToggle<CR>
" gs git status
nnoremap <silent> <leader>gs :Gstatus<CR>

" Golang
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gb <Plug>(go-build)
au FileType go nmap <Leader>gt <Plug>(go-test)

" Switch to h file of same name (useful for c++, obj-c, etc)
" go to header
nnoremap <silent> <leader>gh :e %<.h<CR>
" go to implementation file
nnoremap <silent> <leader>gm :e %<.m<CR>

" ########## Strip trailing whitespaces ###########

fun! <SID>StripTrailingWhitespaces()
    let l = line('.')
    let c = col('.')
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" ########## Filetype/syntax detection ###########

" The reason to not set filetype is that
" linter gets filled w/ errors
au BufRead,BufNewFile *.stencil set syntax=swift
au BufRead,BufNewFile Brewfile set syntax=ruby
au BufRead,BufNewFile Deliverfile set syntax=ruby
au BufRead,BufNewFile Fastfile set syntax=ruby
au BufRead,BufNewFile Gymfile set syntax=ruby
au BufRead,BufNewFile Rakefile set syntax=ruby
au BufRead,BufNewFile Gemfile set syntax=ruby
au BufRead,BufNewFile Podfile set syntax=ruby
au BufRead,BufNewFile Cartfile set syntax=ruby
au BufRead,BufNewFile *.podspec set syntax=ruby
au BufRead,BufNewFile *.fish set syntax=vim

" Set the filetype based on the file's extension, but only if
" 'filetype' has not already been set
au BufRead,BufNewFile Dangerfile setfiletype ruby

" ########## GENERAL SETTINGS ###########

" Referenced https://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  "Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " bind K to grep word under cursor
  nnoremap <silent> K :Ag <C-R><C-W><CR>
  " bind \ (backward slash) to grep shortcut
  nnoremap \ :Ag<SPACE>
endif
" Hide mode menu
set noshowmode
" Make $ not pickup newlines by mapping to similar binding
nmap $ g_
" Hybrid relative line numbers
set number relativenumber
" Switch between line number schemes depending on mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" Live preview of search and replace
set inccommand=nosplit

" Turn off GitGutter by default
" Enable w/ :GitGutterToggle
let g:gitgutter_enabled = 0
" Ignore whitespace
let g:gitgutter_diff_args = '-w'

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
" Set max line length indicator
set colorcolumn=100

" ########### Split func ###############

function! BreakHere()
    s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
    call histdel('/', -1)
endfunction

" ########### Proper tabs ###############

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" ########### ALE SETTINGS ###############

"keep the sign gutter open at all times
let g:ale_sign_column_always = 1
" Keybindings for jumping to next/previous error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Error and warning signs.
"let g:ale_sign_error = '⤫'
"let g:ale_sign_warning = '-'

" ########## LIGHTLINE SETTINGS ###########

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \  'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

" let g:lightline#ale#indicator_checking = "\uf110"
" let g:lightline#ale#indicator_warnings = "\uf071"
" let g:lightline#ale#indicator_errors = "\uf05e"
" let g:lightline#ale#indicator_ok = "\uf00c"

" ###### MARKDOWN SETTINGS #############

let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 1
set conceallevel=2
autocmd FileType markdown setlocal indentexpr=
autocmd FileType markdown setlocal ts=4 sw=4 sts=0 expandtab " probably unneeded

" Formats URLs taken from furik to markdown nicely
function FormatURL ()
    let a:line_number=line('.')
    execute a:line_number ',' . a:line_number . 's/\[.*\]\((.*)\): \(.*\)\s(.*/[\2]\1/g'
endfunction

vnoremap <silent><leader>fu :call FormatURL()<CR>

function AddNumbers ()
  execute "normal! I" . line('.') . ". \<esc>"
endfunction

vnoremap <silent><leader>n :call AddNumbers()<CR>

" ############ Swift Settings ###############

" swiftformat
nnoremap <leader>F :!swiftformat --config ~/.dotfiles/swift/.swiftformat %<cr>

" Makes sure Swift files are recognized as such
autocmd BufNewFile,BufRead *.swift set filetype=swift

function AddMark ()
    let a:line_number=line('.')
    normal! i// MARK: -
endfunction

nmap <silent><leader>xm :call AddMark()<CR>

" A function for changing declaration/call like getItem(a: aLongName, b: anotherLongName)
" into a multiline declaration/call
function BreakLines ()
    let a:line_number=line('.')

    " Replace ( and comma w/ ( newline
    execute a:line_number . ',' . a:line_number . 's/\((\|,\s\)/\1\r/g'

    " Get new line number
    let a:new_line_number=line('.')
    execute a:new_line_number . ',' . a:new_line_number . 's/)/\r)'
endfunction

" A function to change a func into a computed var
function FuncToVar ()
    let a:line_number=line('.')
    execute a:line_number . ',' . a:line_number . 's/func \(.*\)(.*) -> \(.*\)\s/var \1: \2 /g'
endfunction

nmap <silent><leader>b :call BreakLines()<CR>
" tv for transform to var
nnoremap <silent> <leader>tv :<C-u>call FuncToVar()<CR>

" ############ vim-xcode ###################

let g:xcode_default_simulator = 'iPhone 8'
" Prefer schemes that don't have below pattern
let g:xcode_scheme_ignore_pattern = '/Demo|Example|Package|AFNetworking|Bitlyzer|Kit|Bolts|GPUImage|Growthbeat|libwebp|View|lottie-ios/d'
" Set default shell to Bash (needed for Xcodebuild)
set shell=/usr/local/bin/bash

au FileType swift nmap <Leader>xr :Xrun <CR>
au FileType swift nmap <Leader>xb :split <CR> :Xbuild <CR>
au FileType swift nmap <Leader>xt :split <CR> :Xtest <CR>
" Open in Xcode
au FileType swift nmap <Leader>xo :Xopen <CR>

" ############ Golang Settings ##############

let g:ale_linters = {'go': ['gofmt', 'gotype', 'govet']}
" Auto-import on save
let g:go_fmt_command = 'goimports'

" ############ AUTOCOMPLETE #################

" Enable Deoplete
let g:deoplete#enable_at_startup = 1
" Set bracket autocompletion (might not be working)
call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])
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

" ######## Netrw settings ############

" Prevent netrw from loading
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" ######## Remember Settings After Quiting ############

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" ######## CTags! ############

" Setting this option will result in Tagbar omitting the short help at the
" top of the window and the blank lines in between top-level scopes
let g:tagbar_compact = 1

" Markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

" Golang
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
    \ }

" Obj-c
" add a definition for Objective-C to tagbar
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
    \ }
