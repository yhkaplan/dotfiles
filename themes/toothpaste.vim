" Vim color file
" Converted from Textmate theme Toothpaste using Coloration v0.4.0 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "toothpaste"

hi Cursor ctermfg=17 ctermbg=59 cterm=NONE guifg=#222e33 guibg=#465e68 gui=NONE
hi Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#49483e gui=NONE
hi CursorLine ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#344045 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#344045 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#344045 gui=NONE
hi LineNr ctermfg=102 ctermbg=NONE cterm=NONE guifg=#7e898e guibg=#344045 gui=NONE
hi VertSplit ctermfg=59 ctermbg=59 cterm=NONE guifg=#576267 guibg=#576267 gui=NONE
hi MatchParen ctermfg=71 ctermbg=NONE cterm=underline guifg=#62a665 guibg=NONE gui=underline
hi StatusLine ctermfg=188 ctermbg=59 cterm=bold guifg=#dae3e8 guibg=#576267 gui=bold
hi StatusLineNC ctermfg=188 ctermbg=59 cterm=NONE guifg=#dae3e8 guibg=#576267 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#49483e gui=NONE
hi IncSearch ctermfg=17 ctermbg=186 cterm=NONE guifg=#222e33 guibg=#dbcd7f gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e36868 guibg=NONE gui=NONE
hi Folded ctermfg=59 ctermbg=17 cterm=NONE guifg=#465e68 guibg=#222e33 gui=NONE

hi Normal ctermfg=188 ctermbg=NONE cterm=NONE guifg=#dae3e8 guibg=#222e33 gui=NONE
hi Boolean ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e36868 guibg=NONE gui=NONE
hi Character ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e36868 guibg=NONE gui=NONE
hi Comment ctermfg=59 ctermbg=NONE cterm=NONE guifg=#465e68 guibg=NONE gui=NONE
hi Conditional ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi DiffAdd ctermfg=188 ctermbg=64 cterm=bold guifg=#dae3e8 guibg=#45840f gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8a090a guibg=NONE gui=NONE
hi DiffChange ctermfg=188 ctermbg=22 cterm=NONE guifg=#dae3e8 guibg=#213c5d gui=NONE
hi DiffText ctermfg=188 ctermbg=24 cterm=bold guifg=#dae3e8 guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=187 ctermbg=168 cterm=NONE guifg=#c5c5c0 guibg=#c54f7a gui=NONE
hi WarningMsg ctermfg=187 ctermbg=168 cterm=NONE guifg=#c5c5c0 guibg=#c54f7a gui=NONE
hi Float ctermfg=150 ctermbg=NONE cterm=NONE guifg=#9dc777 guibg=NONE gui=NONE
hi Function ctermfg=107 ctermbg=NONE cterm=NONE guifg=#97b853 guibg=NONE gui=NONE
hi Identifier ctermfg=73 ctermbg=NONE cterm=NONE guifg=#73b3c0 guibg=NONE gui=italic
hi Keyword ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi Label ctermfg=186 ctermbg=NONE cterm=NONE guifg=#dbcd7f guibg=NONE gui=NONE
hi NonText ctermfg=59 ctermbg=NONE cterm=NONE guifg=#3b3a32 guibg=#2b373c gui=NONE
hi Number ctermfg=150 ctermbg=NONE cterm=NONE guifg=#9dc777 guibg=NONE gui=NONE
hi Operator ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi PreProc ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi Special ctermfg=188 ctermbg=NONE cterm=NONE guifg=#dae3e8 guibg=NONE gui=NONE
hi SpecialKey ctermfg=59 ctermbg=NONE cterm=NONE guifg=#3b3a32 guibg=#344045 gui=NONE
hi Statement ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi StorageClass ctermfg=73 ctermbg=NONE cterm=NONE guifg=#73b3c0 guibg=NONE gui=italic
hi String ctermfg=186 ctermbg=NONE cterm=NONE guifg=#dbcd7f guibg=NONE gui=NONE
hi Tag ctermfg=188 ctermbg=NONE cterm=NONE guifg=#dae3e8 guibg=NONE gui=NONE
hi Title ctermfg=188 ctermbg=NONE cterm=bold guifg=#dae3e8 guibg=NONE gui=bold
hi Todo ctermfg=59 ctermbg=NONE cterm=inverse,bold guifg=#465e68 guibg=NONE gui=inverse,bold
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi rubyFunction ctermfg=107 ctermbg=NONE cterm=NONE guifg=#97b853 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e36868 guibg=NONE gui=NONE
hi rubyConstant ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=186 ctermbg=NONE cterm=NONE guifg=#dbcd7f guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=173 ctermbg=NONE cterm=NONE guifg=#c88e4b guibg=NONE gui=italic
hi rubyInstanceVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInclude ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp ctermfg=186 ctermbg=NONE cterm=NONE guifg=#dbcd7f guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=186 ctermbg=NONE cterm=NONE guifg=#dbcd7f guibg=NONE gui=NONE
hi rubyEscape ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e36868 guibg=NONE gui=NONE
hi rubyControl ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi rubyException ctermfg=71 ctermbg=NONE cterm=NONE guifg=#62a665 guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=59 ctermbg=NONE cterm=NONE guifg=#465e68 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e36868 guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=73 ctermbg=NONE cterm=NONE guifg=#73b3c0 guibg=NONE gui=italic
hi javaScriptRailsFunction ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=188 ctermbg=NONE cterm=NONE guifg=#dae3e8 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAlias ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=186 ctermbg=NONE cterm=NONE guifg=#dbcd7f guibg=NONE gui=NONE
hi cssURL ctermfg=173 ctermbg=NONE cterm=NONE guifg=#c88e4b guibg=NONE gui=italic
hi cssFunctionName ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi cssColor ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e36868 guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=188 ctermbg=NONE cterm=NONE guifg=#dae3e8 guibg=NONE gui=NONE
hi cssClassName ctermfg=188 ctermbg=NONE cterm=NONE guifg=#dae3e8 guibg=NONE gui=NONE
hi cssValueLength ctermfg=150 ctermbg=NONE cterm=NONE guifg=#9dc777 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=109 ctermbg=NONE cterm=NONE guifg=#769eb3 guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
