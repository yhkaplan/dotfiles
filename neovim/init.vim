" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" Dasht docs
Plug 'sunaku/vim-dasht'
" Tags
Plug 'ludovicchabant/vim-gutentags'
" Run in Tmux
Plug 'benmills/vimux'
" Formatting
Plug 'sbdchd/neoformat'
" Directory brower, replacement for netrw
Plug 'ap/vim-readdir'
" Running swift test, gotest, etc
Plug 'janko-m/vim-test'
" Xcodebuild, run, etc
Plug 'gfontenot/vim-xcode'
" Swift syntax highlighting
Plug 'keith/swift.vim'
" Asynchronous building
Plug 'tpope/vim-dispatch'
" Surrounding with quote, bracket, etc
Plug 'tpope/vim-surround'
" Commenting out
Plug 'tpope/vim-commentary'
" Detect indent type etc
Plug 'tpope/vim-sleuth'
" Git integration
Plug 'tpope/vim-fugitive'
" Git diff integration
Plug 'airblade/vim-gitgutter'
" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Bracket and quote completion
Plug 'Shougo/neopairs.vim'
Plug 'jiangmiao/auto-pairs'
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Swift completion (not clear if it's working)
Plug 'mitsuse/autocomplete-swift'
" Python autocomplete
Plug 'zchee/deoplete-jedi'
" Go-lang completion
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'fatih/vim-go'
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
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
Plug 'mhartington/oceanic-next'

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

syntax on
let g:oceanic_next_terminal_bold = 0
let g:oceanic_next_terminal_italic = 0
colorscheme OceanicNext

" set background=dark " for the dark version
"colorscheme one

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

" Search tags for word under cursor
nnoremap <silent>z :call fzf#vim#tags(expand('<cword>'))<CR>
" s for search
nnoremap <silent> <leader>s :GFiles<CR>
" gl for git log
nnoremap <silent> <leader>gl :Commits<CR>
" c for commands
nnoremap <silent> <leader>c :History:<CR>
" r for recent
nnoremap <silent> <leader>H :Hist<CR>
nnoremap <silent> <leader>r :Buffers<CR>
" K for Keybindings
nnoremap <silent> <leader>K :Maps<CR>
" L for git Log
nnoremap <silent> <leader>L :Commits<CR>
" Return to last viewed buffer
nnoremap <silent> <leader>b :b#<CR>

" Setting this to begin with space f because I mostly plan on
" using it to find functions
nnoremap <silent> <leader>f :BTags<CR>
nnoremap <silent> <leader>F :Tags<CR>

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

" Format
nnoremap <leader>N :Neoformat<CR>

" vim-fugitive/git
" ga for git add
nnoremap <silent> <leader>ga :Gwrite<CR>
" gc git commit
nnoremap <silent> <leader>gc :Gcommit<CR>
" gp git push
nnoremap <silent> <leader>gp :Gpush<CR>
" gd git diff
nnoremap <silent> <leader>gd :GitGutterToggle<CR>
" git full diff
nnoremap <silent> <leader>gf :tabnew<CR>:terminal git diff -w<CR>
" gs git status
nnoremap <silent> <leader>gs :Gstatus<CR>

" Dasht
" search related docsets TODO: make Swift/Python/Ruby/Bash/Vim only
nnoremap <silent> <Leader>gd :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>

" use gw to swap the current word with the next, without changing cursor position
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>

" Golang
augroup go
  autocmd!
  autocmd Filetype go
    \  nnoremap <silent> <leader>f :GoDecls<CR>
    \| nnoremap <silent> <leader>F :GoDeclsDir<CR>
    \| inoreabbr iferr <C-R>=go#iferr#Generate()<CR><esc>x
    \| nmap <Leader>gd <Plug>(go-doc)
    \| nmap <Leader>gr <Plug>(go-run)
    \| nmap <Leader>gb <Plug>(go-build)
    \| nmap <Leader>gt <Plug>(go-test)
    \| nmap <Leader>R  <Plug>(go-rename)
    \| command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  " Alternates between the implementation and test code

  " Try out :GoAddTags and :GoRemoveTags for struct in Go!
  " TODO: assign bindings
  " :GoImpl [receiver] [interface]
  " Generates method stubs for implementing an interface. If no arguments is
  " passed it takes the identifier under the cursor to be the receiver and
  " asks for the interface type to be generated. If used with arguments, the
  " receiver and the interface needs to be specified.
  "
  " autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
augroup END

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

if executable('rg')
  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
    \ -g "!{.git,node_modules,vendor}/*" '

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
endif

" Hide mode menu
set noshowmode
" Exit on j
imap jj <Esc>
" Center the screen
nnoremap <space> zz
" Make $ not pickup newlines by mapping to similar binding
nmap $ g_
" sensible yank til last character
nnoremap Y y$
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
" Workaround for bug reducing startup time
let g:clipboard = {'copy': {'+': 'pbcopy', '*': 'pbcopy'}, 'paste': {'+': 'pbpaste', '*': 'pbpaste'}, 'name': 'pbcopy', 'cache_enabled': 0}
set clipboard=unnamed
" Fixes cursor
set guicursor=
" Set max line length indicator
set colorcolumn=100
" Reload vim config
command! Reload execute "source $MYVIMRC"

" ########### Split func ###############
" TODO: make swift only
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
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '▲'

" ########## Neosnippets ###########

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" ########## LIGHTLINE SETTINGS ###########

let g:lightline = {
      \ 'colorscheme': 'oceanicnext',
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
" TODO: make md only
function FormatURL ()
    let a:line_number=line('.')
    execute a:line_number ',' . a:line_number . 's/\[.*\]\((.*)\): \(.*\)\s(.*/[\2]\1/g'
endfunction

" Todo make markdown only and change to : style command
vnoremap <silent><leader>fu :call FormatURL()<CR>

function AddNumbers ()
  execute "normal! I" . line('.') . ". \<esc>"
endfunction

vnoremap <silent><leader>n :call AddNumbers()<CR>

" ############ Swift Settings ###############

" Makes sure Swift files are recognized as such
autocmd BufNewFile,BufRead *.swift set filetype=swift
autocmd BufNewFile,BufRead *.swift,*.h,*.m set tags+=~/dev/global-tags
let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
let g:gutentags_ctags_tagfile = '.git/tags'
let g:gutentags_ctags_extra_args = ['--languages=objectivec,swift', '--langmap=objectivec:.h.m']

" TODO: make swift only
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

nmap <silent><leader>B :call BreakLines()<CR>
" tv for transform to var
nnoremap <silent> <leader>tv :<C-u>call FuncToVar()<CR>

" ############ vim-xcode ###################

let g:xcode_default_simulator = 'iPhone 8'
" Prefer schemes that don't have below pattern
let g:xcode_scheme_ignore_pattern = '/Demo|Example|Package|AFNetworking|Bitlyzer|Kit|Bolts|GPUImage|Growthbeat|libwebp|View|lottie-ios/d'
" Xcodebuild asynchronously w/ vim-dispatch
" let g:xcode_runner_command = 'Make {cmd}'

" Set default shell to Bash (needed for Xcodebuild)
function! SetShellToBash ()
  set shell=/usr/local/bin/bash
endfunction

set lazyredraw              " Don't redraw vim in all situations
set title                   " Change the terminal's title
set secure                  " Don't load autocmds from local .vimrc files
nmap <Leader>xr :Xrun<CR>
nmap <Leader>xb :call SetShellToBash()<CR>:Xbuild<CR>
nmap <Leader>xt :Xtest<CR>
" Open in Xcode
nmap <Leader>xo :Xopen<CR>
" Run pod install w/ vim-dispatch
nmap <Leader>xp :call VimuxRunCommand("clear; bundle exec pod install")<CR>
" S for Swift REPL; Open and switch to REPL
nmap <Leader>xs :call VimuxRunCommand("clear; swift")<CR>

nmap <Leader>. :VimuxRunLastCommand<CR>
nmap <Leader>x :VimuxCloseRunner<CR>

" ############ Golang Settings ##############

let g:ale_linters = {'go': ['gofmt', 'gotype', 'govet']}
let g:go_fmt_command = 'goimports' " Auto-import on save

function CheckGoVersion ()
  let go_version = system('go version')
  if go_version !=# "go version go1.11 darwin/amd64\n"
    echo 'Go version change detected. Running gorebuild...'
    echo go_version
    " Update first just in case
    call system('go get -u github.com/FiloSottile/gorebuild')
    call system('gorebuild')
    echo 'Updating plugins too just in case'
    :PlugUpdate()<cr>
  endif
endfunction

" Check Go version to see if everything needs to be updated
" to fix vim-go autocompletion
" call CheckGoVersion ()

" ############ AUTOCOMPLETE #################

" Enable Deoplete
let g:deoplete#enable_at_startup = 1
" Set bracket autocompletion (might not be working)
call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 2

" Fix behavior of deoplete adding unwanted return chars
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? deoplete#mappings#close_popup() : "\n"
endfunction

" Swift settings
" Jump to the first placeholder by typing `<C-k>`.
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
let g:deoplete#sources#swift#source_kitten_binary = '/usr/local/bin/sourcekitten'
let g:deoplete#sources#swift#daemon_autostart = 1

" Golang deoplete settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
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
set viminfo='10,\"100,:20,%,n~/.config/nvim/.viminfo

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

" ----------------------------------------------------------------------------
" Functions by @junegunn
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" #gi / #gpi | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>
" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()
" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()
" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let x = line('$')
  let d = [a:b, a:e]

  if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
    let [b, e] = [a:b, a:e]
    while b > 0 && e <= line('$')
      let b -= 1
      let e += 1
      let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
      if i > 0
        break
      endif
    endwhile
  endif

  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)

      if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction

xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>

" ----------------------------------------------------------------------------
" <Leader>I/A | Prepend/Append to all adjacent lines with same indentation
" ----------------------------------------------------------------------------
nmap <silent> <leader>I ^vio<C-V>I
nmap <silent> <leader>A ^vio<C-V>$A
