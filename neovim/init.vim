" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" GraphQL support
Plug 'jparise/vim-graphql'
" camelCase and snake_case word objects/motions
Plug 'chaoren/vim-wordmotion'
" Tags
Plug 'ludovicchabant/vim-gutentags'
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Formatting
Plug 'sbdchd/neoformat'
" Directory brower, replacement for netrw
Plug 'ap/vim-readdir'
" Swift syntax highlighting
Plug 'keith/swift.vim'
" Surrounding with quote, bracket, etc
Plug 'tpope/vim-surround'
" Auto add endings for Ruby, Vimscript etc.
Plug 'tpope/vim-endwise'
" Commenting out
Plug 'tpope/vim-commentary'
" Detect indent type etc
Plug 'tpope/vim-sleuth'
" Git integration
Plug 'tpope/vim-fugitive'
" Bracket and quote completion
Plug 'Shougo/neopairs.vim'
Plug 'cohama/lexima.vim'
" Go
Plug 'fatih/vim-go'
" FZF (through Homebrew)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Airline status bar below
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
" ALE Linting for Go, Swift, etc
Plug 'w0rp/ale'
" Completion
Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'

" Theme
Plug 'joshdick/onedark.vim'

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
colorscheme onedark

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

" Search tags for word under cursor
nnoremap <silent> <leader>z :call fzf#vim#tags(expand('<cword>'))<CR>
" s for search
nnoremap <silent> <leader>s :GFiles<CR>
" gl for git log
nnoremap <silent> <leader>gl :Commits<CR>
" c for commands
nnoremap <silent> <leader>c :History:<CR>
" K for Keybindings
nnoremap <silent> <leader>K :Maps<CR>
" L for git Log
nnoremap <silent> <leader>L :Commits<CR>
nnoremap <silent> <leader>Bu :Buffers<CR>
" Return to last viewed buffer (r for recent)
nnoremap <silent> <leader>R :b#<CR>

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
nnoremap <silent> <leader>v :<C-u>call MakeIntoComputedVar()<CR>
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

let g:wordmotion_prefix = '<Leader>'

" use gw to swap the current word with the next, without changing cursor position
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>

" for Japanese IME mode"{{{
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap え e
nnoremap お o
nnoremap っd dd
nnoremap っy yy
nnoremap し” ci"
nnoremap し’ ci'
nnoremap せ ce
nnoremap で de
inoremap <silent> っj <ESC>

nnoremap っz zz
nnoremap ・ /
"}}}

" Golang
augroup go
  autocmd!
  autocmd Filetype go
    \  nnoremap <silent> <leader>f :GoDecls<CR>
    \| nnoremap <silent> <leader>F :GoDeclsDir<CR>
    \| inoreabbr iferr <C-R>=go#iferr#Generate()<CR><esc>x
    \| nmap <Leader>d <Plug>(go-doc)
    \| nmap <Leader>r <Plug>(go-run)
    \| nmap <Leader>b <Plug>(go-build)
    \| nmap <Leader>t <Plug>(go-test)
    \| nmap <Leader>R  <Plug>(go-rename)
    \| command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  " Alternates between the implementation and test code

  " :call GoToggleBreakpoint() to add or remove a breakpoint at the current line
  " :call GoDebug() to start a debug session for the main package
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

" Turns off loud fixit window
let g:go_fmt_fail_silently = 1
" Display type info for function parameters automatically
let g:go_auto_type_info = 1
" More colorful syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

" Close quickfix window
nnoremap <leader>q :cclose<CR>:only<CR>

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
au BufRead,BufNewFile *.podspec set syntax=ruby

" Set the filetype based on the file's extension, but only if
" 'filetype' has not already been set
au BufRead,BufNewFile *file setfiletype ruby

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
" No adding spaces in joined lines
nnoremap J gJ
" Center the screen
nnoremap <space> zz
" Make $ not pickup newlines by mapping to similar binding
nmap $ g_
" sensible yank til last character
nnoremap Y y$
" Live preview of search and replace (Neovim only)
set inccommand=nosplit
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Enable CursorLine
set cursorline
" Always split to the right
set splitright
set splitbelow
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
" Disable swapfile
set noswapfile
" Use macOS pasteboard
" Workaround for bug reducing startup time
let g:clipboard = {'copy': {'+': 'pbcopy', '*': 'pbcopy'}, 'paste': {'+': 'pbpaste', '*': 'pbpaste'}, 'name': 'pbcopy', 'cache_enabled': 0}
set clipboard=unnamed
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_python_provider=1 " Disable Python 2 provider

" Fixes cursor
set guicursor=
" Set max line length indicator
set colorcolumn=100
" Reload vim config
command! Reload execute "source $MYVIMRC"

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
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
" Error and warning signs.
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '▲'

" ########## Completion  ###########

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

lua << EOF
require'lspconfig'.bashls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.sourcekit.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.tsserver.setup{}
EOF

" ########## Gitgutter ###########
let g:gitgutter_diff_args = '-w'
" タイピング停止時から反映されるまでの時間はデフォルトでは4000ミリ秒なので、速くしたい
set updatetime=250
" 記号の変更
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '*'
let g:gitgutter_enabled=0 " Disable at first to improve performance

" また、ハンク内で<Leader>hsを押すと変更をステージでき、<Leader>hrを押せば変更を元に戻せる
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterRevertHunk

function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! 1G
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction

nmap <silent> ]C :call NextHunkAllBuffers()<CR>
nmap <silent> [C :call PrevHunkAllBuffers()<CR>

" ########## LIGHTLINE SETTINGS ###########

let g:lightline = {
      \ 'colorscheme': 'onedark',
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

" ###### MARKDOWN SETTINGS #############

let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 1
set conceallevel=2

" Formats URLs taken from furik to markdown nicely
function FormatURL ()
    let a:line_number=line('.')
    execute a:line_number ',' . a:line_number . 's/:\s.*//'
endfunction

augroup markdown
  autocmd!
  autocmd FileType markdown,md
    \  setlocal indentexpr=
    \| setlocal ts=4 sw=4 sts=0 expandtab
    \| vnoremap <silent><leader>fu :call FormatURL()<CR>
augroup END

" ############ Swift Settings ###############

" Makes sure Swift files are recognized as such
autocmd BufNewFile,BufRead *.swift set filetype=swift
autocmd BufNewFile,BufRead *.swift,*.h,*.m set tags+=~/dev/global-tags
let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
let g:gutentags_ctags_tagfile = '.git/tags'
let g:gutentags_ctags_extra_args = ['--languages=objectivec,swift,ruby,python', '--langmap=objectivec:.h.m']

" ############ Golang Settings ##############

let g:ale_linters = {'go': ['gofmt', 'gotype', 'govet']}
let g:go_fmt_command = 'goimports' " Auto-import on save
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'structcheck']
let g:go_gocode_unimported_packages = 1

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

" ----------------------------------------------------------------------------
" Session management (saving window position, etc)
" http://vim.wikia.com/wiki/Automatic_session_restore_in_git_directories
" ----------------------------------------------------------------------------
function! FindProjectName()
  let s:name = getcwd()
  if !isdirectory('.git')
    let s:name = substitute(finddir('.git', '.;'), '/.git', "", "")
  end
  if s:name != ''
    let s:name = matchstr(s:name, '.*', strridx(s:name, '/') + 1)
  end
  return s:name
endfunction

" Sessions only restored if we start Vim without args.
function! RestoreSession(name)
  let s:session_path = $HOME . '/.config/nvim/sessions/' . a:name
  if a:name != ''
    if filereadable(s:session_path)
      execute 'source ' . s:session_path
    end
  end
endfunction

" Sessions only saved if we start Vim without args.
function! SaveSession(name)
  if a:name != ''
    let s:sessions_dir = $HOME . '/.config/nvim/sessions/'
    if !isdirectory(s:sessions_dir)
      call mkdir(s:sessions_dir)
    endif
    execute 'mksession! ' . s:sessions_dir . a:name
  end
endfunction

" Restore and save sessions.
if argc() == 0
  " Nested restored syntax highlighting etc
  autocmd VimEnter * nested call RestoreSession(FindProjectName())
  autocmd VimLeave * call SaveSession(FindProjectName())
end
