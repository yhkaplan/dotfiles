" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" Directory brower, replacement for netrw
Plug 'ap/vim-readdir'
" Running swift test, gotest, etc
Plug 'janko-m/vim-test'
" Xcodebuild, run, etc
Plug 'gfontenot/vim-xcode'
" Swift syntax highlighting
Plug 'keith/swift.vim'
" Bracket and quote completion
Plug 'jiangmiao/auto-pairs'
" Surrounding with quote, bracket, etc
Plug 'tpope/vim-surround'
" Commenting out
Plug 'tpope/vim-commentary'
" Control Tmux
Plug 'benmills/vimux'
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
nnoremap <silent> <leader>tn :tabnew<CR>
"tab next, tab to the right
nnoremap <silent> <leader>tl :tabn<CR>
" Sane defaults for split switching
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" s for search
nnoremap <silent> <leader>s :FZF<CR>
" Setting this to begin with space f because I mostly plan on
" using it to find functions
nnoremap <silent> <leader>f :BTags<CR>
" gl for git log
nnoremap <silent> <leader>gl :Commits<CR>
" c for commands
nnoremap <silent> <leader>H :History:<CR>
nnoremap <silent> <leader>B :Buffers<CR>
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
" Insert newline below
nnoremap <silent> <leader>o o<Esc>k
" Insert newline above
nnoremap <silent> <leader>O O<Esc>j
" Insert space after
nnoremap <silent> <leader>i i<space><esc>
" Insert space before
nnoremap <silent> <leader>I hi<space><esc>
" Indent current line
nnoremap <silent> <leader>> V><esc>
nnoremap <silent> <leader>< V<<esc>

" vim-fugitive/git
" ga for git add
nnoremap <silent> <leader>ga :Gwrite<CR>
" gc git commit
nnoremap <silent> <leader>gc :Gcommit<CR>
" gp git push
nnoremap <silent> <leader>gp :Gpush<CR>
" gd git diff
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gg :GitGutterToggle<CR>
" gs git status
nnoremap <silent> <leader>gs :Gstatus<CR>

" Golang
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gb <Plug>(go-build)
au FileType go nmap <Leader>gt <Plug>(go-test)

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

" Set the filetype based on the file's extension, but only if
" 'filetype' has not already been set
au BufRead,BufNewFile Dangerfile setfiletype ruby

" ########## GENERAL SETTINGS ###########

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

" ############ Swift Settings ###############

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
    let a:indent_number=indent(a:line_number)

    " Replace ( and comma w/ ( newline
    execute a:line_number . ',' . a:line_number . 's/\((\|,\s\)/\1\r/g'

    " Get new line number
    let a:new_line_number=line('.')
    execute a:new_line_number . ',' . a:new_line_number . 's/)/\r)'

    " Indent between line and newline
    let a:start_line=a:line_number + 1
    let a:finish_line=a:new_line_number
    let a:range=a:finish_line - a:start_line

    " let a:i = 0
    " while a:i <= a:indent_number
        " a:range v
        " >
        " a:i += 1
    " endwhile
    "execute a:line_number . ',' . a:new_line_number . 's/)/\r)'
endfunction

nmap <silent><leader>b :call BreakLines()<CR>

" ############ vim-xcode ###################

let g:xcode_default_simulator = 'iPhone 8'
" Prefer schemes that don't have below pattern
let g:xcode_scheme_ignore_pattern = '/Demo|Example|Package|AFNetworking|Bitlyzer|Kit|Bolts|GPUImage|Growthbeat|libwebp|View|lottie-ios/d'
" Set default shell to Bash (needed for Xcodebuild)
set shell=/usr/local/bin/bash

au FileType swift nmap <Leader>xr :Xrun <CR>
au FileType swift nmap <Leader>xb :Xbuild <CR>
au FileType swift nmap <Leader>xt :Xtest <CR>
" Open in Xcode
au FileType swift nmap <Leader>xo :Xopen <CR>

" ############ Golang Settings ##############

let g:ale_linters = {'go': ['gofmt', 'gotype', 'govet']}
" Auto-import on save
let g:go_fmt_command = 'goimports'

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

" ######## Netrw settings ############

" Prevent netrw from loading
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

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
