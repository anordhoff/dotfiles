" ----------------------------------------------------------
" general settings
" ----------------------------------------------------------

" highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'colorscheme'

" --------------------------------------
" variable types
" --------------------------------------
hi Normal                        cterm=none        ctermfg=7        ctermbg=none
hi Comment                       cterm=none        ctermfg=8        ctermbg=none

hi Constant                      cterm=none        ctermfg=7        ctermbg=none
hi String                        cterm=none        ctermfg=4        ctermbg=none
hi Character                     cterm=none        ctermfg=7        ctermbg=none
hi Number                        cterm=none        ctermfg=7        ctermbg=none
hi Boolean                       cterm=none        ctermfg=7        ctermbg=none
hi Float                         cterm=none        ctermfg=7        ctermbg=none

hi Identifier                    cterm=none        ctermfg=7        ctermbg=none
hi Function                      cterm=none        ctermfg=7        ctermbg=none

hi Statement                     cterm=none        ctermfg=7        ctermbg=none
hi Conditional                   cterm=none        ctermfg=6        ctermbg=none
hi Repeat                        cterm=none        ctermfg=6        ctermbg=none
hi Label                         cterm=none        ctermfg=6        ctermbg=none
hi Operator                      cterm=none        ctermfg=7        ctermbg=none
hi Keyword                       cterm=none        ctermfg=6        ctermbg=none
hi Exception                     cterm=none        ctermfg=7        ctermbg=none

hi PreProc                       cterm=none        ctermfg=7        ctermbg=none
hi! link Include                 PreProc
hi! link Define                  PreProc
hi! link Macro                   PreProc
hi! link PreCondit               PreProc

hi Type                          cterm=none        ctermfg=7        ctermbg=none
hi! link StorageClass            Type
hi! link Structure               Type
hi! link Typedef                 Type

hi Special                       cterm=none        ctermfg=7        ctermbg=none
hi! link SpecialChar             Special
hi! link Tag                     Special
hi! link Delimiter               Special
hi! link SpecialComment          Special
hi! link Debug                   Special

" --------------------------------------
" editor settings
" --------------------------------------
hi Cursor                        cterm=reverse     ctermfg=8        ctermbg=none
hi! link TermCursor              Cursor
hi CursorLine                    cterm=none        ctermfg=none     ctermbg=0
hi! link CursorLIneNr            LineNr
hi! link CursorColumn            CursorLine
hi! link ColorColumn             CursorLine

" --------------------------------------
" number column
" --------------------------------------
hi LineNr                        cterm=none        ctermfg=11       ctermbg=none
hi SignColumn                    cterm=none        ctermfg=7        ctermbg=none
hi FoldColumn                    cterm=none        ctermfg=7        ctermbg=none
hi Folded                        cterm=none        ctermfg=6        ctermbg=none

" --------------------------------------
" window/tab delimiters
" --------------------------------------
hi WinSeparator                  cterm=none        ctermfg=11       ctermbg=none
hi TabLine                       cterm=none        ctermfg=7        ctermbg=10
hi TabLineFill                   cterm=none        ctermfg=none     ctermbg=10
hi TabLineSel                    cterm=none        ctermfg=6        ctermbg=10

" --------------------------------------
" prompt / status
" --------------------------------------
" StatusLine and StatusLineNC are used for the bookends of the statusline
hi StatusLine                    cterm=none        ctermfg=7        ctermbg=none
hi StatusLineNC                  cterm=none        ctermfg=7        ctermbg=none
hi StatusLineActive              cterm=none        ctermfg=7        ctermbg=13
hi StatusLineInactive            cterm=none        ctermfg=7        ctermbg=10
hi WildMenu                      cterm=none        ctermfg=5        ctermbg=13
hi Question                      cterm=none        ctermfg=2        ctermbg=none
hi Title                         cterm=none        ctermfg=3        ctermbg=none
hi ModeMsg                       cterm=none        ctermfg=7        ctermbg=none
hi MoreMsg                       cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" file navigation / searching
" --------------------------------------
hi Directory                     cterm=none        ctermfg=7        ctermbg=none
hi Search                        cterm=reverse     ctermfg=4        ctermbg=none
hi IncSearch                     cterm=reverse     ctermfg=5        ctermbg=none
hi CurSearch                     cterm=reverse     ctermfg=5        ctermbg=none

" --------------------------------------
" completion menu
" --------------------------------------
hi Pmenu                         cterm=none        ctermfg=none     ctermbg=10
hi PmenuSel                      cterm=none        ctermfg=none     ctermbg=13
hi PmenuSbar                     cterm=none        ctermfg=none     ctermbg=11
hi PmenuThumb                    cterm=none        ctermfg=none     ctermbg=8
hi PmenuMatch                    cterm=none        ctermfg=5        ctermbg=10
hi PmenuMatchSel                 cterm=none        ctermfg=5        ctermbg=13

" --------------------------------------
" quickfix
" --------------------------------------
hi QuickFixLine                  cterm=none        ctermfg=none     ctermbg=14
hi qfFileName                    cterm=none        ctermfg=7        ctermbg=none
hi qfLineNr                      cterm=none        ctermfg=8        ctermbg=none

" --------------------------------------
" visual aid
" --------------------------------------
hi MatchParen                    cterm=none        ctermfg=5        ctermbg=none
hi Visual                        cterm=none        ctermfg=none     ctermbg=13
hi VisualNOS                     cterm=none        ctermfg=none     ctermbg=13
hi NonText                       cterm=none        ctermfg=3        ctermbg=none
hi Whitespace                    cterm=none        ctermfg=3        ctermbg=none
hi EndOfBuffer                   cterm=none        ctermfg=11       ctermbg=none
hi Conceal                       cterm=none        ctermfg=2        ctermbg=none
hi SpecialKey                    cterm=none        ctermfg=2        ctermbg=none

hi Underlined                    cterm=underline   ctermfg=none     ctermbg=none
hi Ignore                        cterm=none        ctermfg=3        ctermbg=none
hi Error                         cterm=none        ctermfg=1        ctermbg=none
hi! link ErrorMsg                Error
hi WarningMsg                    cterm=none        ctermfg=3        ctermbg=none
hi Todo                          cterm=none        ctermfg=8        ctermbg=none

" --------------------------------------
" diff
" --------------------------------------
hi DiffAdd                       cterm=reverse     ctermfg=2        ctermbg=none
hi DiffChange                    cterm=none        ctermfg=none     ctermbg=9
hi DiffDelete                    cterm=none        ctermfg=1        ctermbg=none
hi DiffText                      cterm=reverse     ctermfg=3        ctermbg=none

" --------------------------------------
" spelling
" --------------------------------------

" NOTE: ctermsp doesn't exist: https://github.com/neovim/neovim/issues/9270#issuecomment-442648178
hi SpellBad              cterm=undercurl ctermfg=none ctermbg=none guisp=#cc241d
hi SpellCap              cterm=undercurl ctermfg=none ctermbg=none guisp=#d79921
hi SpellLocal            cterm=undercurl ctermfg=none ctermbg=none guisp=#98971a
hi SpellRare             cterm=undercurl ctermfg=none ctermbg=none guisp=#458588

" --------------------------------------
" netrw
" --------------------------------------
hi netrwDir                      cterm=none        ctermfg=4        ctermbg=none
hi netrwSymLink                  cterm=none        ctermfg=5        ctermbg=none

" --------------------------------------
" neovim
" --------------------------------------
hi NormalFloat                   cterm=none        ctermfg=none     ctermbg=none
hi FloatBorder                   cterm=none        ctermfg=8        ctermbg=none


" ----------------------------------------------------------
" languages
" ----------------------------------------------------------

" --------------------------------------
" git
" --------------------------------------
hi gitcommitOverflow             cterm=none        ctermfg=1        ctermbg=none

" --------------------------------------
" go
" --------------------------------------
hi goFormatSpecifier             cterm=none        ctermfg=2        ctermbg=none
hi goEscapeC                     cterm=none        ctermfg=2        ctermbg=none
hi goEscapeError                 cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" json
" --------------------------------------
hi jsonKeyword                   cterm=none        ctermfg=6        ctermbg=none
hi jsonString                    cterm=none        ctermfg=7        ctermbg=none
hi! link jsonNoQuotesError       Normal

" --------------------------------------
" make
" --------------------------------------
hi makeTarget                    cterm=none        ctermfg=6        ctermbg=none
hi makeSpecTarget                cterm=none        ctermfg=5        ctermbg=none

" --------------------------------------
" markdown
" --------------------------------------
hi markdownCode                  cterm=none        ctermfg=2        ctermbg=none
hi markdownCodeBlock             cterm=none        ctermfg=2        ctermbg=none
hi markdownCodeDelimiter         cterm=none        ctermfg=2        ctermbg=none
hi markdownBlockquote            cterm=italic      ctermfg=8        ctermbg=none
hi markdownURL                   cterm=none        ctermfg=8        ctermbg=none
hi markdownLinkDelimiter         cterm=none        ctermfg=8        ctermbg=none
hi markdownLinkText              cterm=underline   ctermfg=4        ctermbg=none
hi markdownLinkTextDelimiter     cterm=none        ctermfg=8        ctermbg=none
hi markdownListMarker            cterm=none        ctermfg=8        ctermbg=none
hi markdownOrderedListMarker     cterm=none        ctermfg=8        ctermbg=none
hi markdownH1                    cterm=none        ctermfg=3        ctermbg=none
hi markdownH2                    cterm=none        ctermfg=4        ctermbg=none
hi markdownH3                    cterm=none        ctermfg=5        ctermbg=none
hi markdownH4                    cterm=none        ctermfg=6        ctermbg=none
hi markdownH5                    cterm=none        ctermfg=2        ctermbg=none
hi markdownH6                    cterm=none        ctermfg=8        ctermbg=none
hi! link markdownH1Delimiter     markdownH1
hi! link markdownH2Delimiter     markdownH2
hi! link markdownH3Delimiter     markdownH3
hi! link markdownH4Delimiter     markdownH4
hi! link markdownH5Delimiter     markdownH5
hi! link markdownH6Delimiter     markdownH6

" --------------------------------------
" shell
" --------------------------------------
hi shQuote                       cterm=none        ctermfg=4        ctermbg=none
hi shDerefSimple                 cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" terraform
" --------------------------------------
hi hclStringInterp               cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" vimscript
" --------------------------------------
hi! link vimCommentTitle         Todo

" --------------------------------------
" yaml
" --------------------------------------
hi yamlBlockMappingKey           cterm=none        ctermfg=6        ctermbg=none


" ----------------------------------------------------------
" plugins
" ----------------------------------------------------------

" --------------------------------------
" copilot
" --------------------------------------
hi CopilotSuggestion             cterm=none        ctermfg=11       ctermbg=none
hi CopilotChatSelection          cterm=none        ctermfg=none     ctermbg=14
hi CopilotChatHeader             cterm=none        ctermfg=5        ctermbg=none
hi CopilotChatSeparator          cterm=none        ctermfg=5        ctermbg=none
hi CopilotChatHelp               cterm=none        ctermfg=8        ctermbg=none

" --------------------------------------
" dirvish
" --------------------------------------
hi DirvishPathTail               cterm=none        ctermfg=4        ctermbg=none
hi DirvishArg                    cterm=none        ctermfg=5        ctermbg=none

" --------------------------------------
" fugitive
" --------------------------------------
hi DiffAdded                     cterm=none        ctermfg=2        ctermbg=none
hi DiffRemoved                   cterm=none        ctermfg=1        ctermbg=none

" --------------------------------------
" indent-blankline
" --------------------------------------
hi IblIndent                     cterm=none        ctermfg=11       ctermbg=none

" --------------------------------------
" leap
" --------------------------------------
hi LeapMatch                     cterm=reverse     ctermfg=4        ctermbg=none
hi LeapLabel                     cterm=reverse     ctermfg=5        ctermbg=none
hi LeapLabelDimmed               cterm=none        ctermfg=7        ctermbg=7

" --------------------------------------
" lsp
" --------------------------------------
hi LspInfoTitle                  cterm=none        ctermfg=7        ctermbg=none
hi LspInfoList                   cterm=none        ctermfg=7        ctermbg=none
hi LspInfoFiletype               cterm=none        ctermfg=7        ctermbg=none
hi LspInfoTip                    cterm=none        ctermfg=2        ctermbg=none
hi! link LspInfoBorder           FloatBorder

hi DiagnosticError               cterm=none        ctermfg=1        ctermbg=none
hi DiagnosticWarn                cterm=none        ctermfg=3        ctermbg=none
hi DiagnosticInfo                cterm=none        ctermfg=2        ctermbg=none
hi DiagnosticHint                cterm=none        ctermfg=4        ctermbg=none
hi DiagnosticOK                  cterm=none        ctermfg=6        ctermbg=none

" NOTE: ctermsp doesn't exist: https://github.com/neovim/neovim/issues/9270#issuecomment-442648178
hi DiagnosticUnderlineError      cterm=undercurl ctermfg=none ctermbg=none guisp=#cc241d
hi DiagnosticUnderlineWarn       cterm=undercurl ctermfg=none ctermbg=none guisp=#d79921
hi DiagnosticUnderlineInfo       cterm=undercurl ctermfg=none ctermbg=none guisp=#98971a
hi DiagnosticUnderlineHint       cterm=undercurl ctermfg=none ctermbg=none guisp=#458588
hi DiagnosticUnderlineOk         cterm=undercurl ctermfg=none ctermbg=none guisp=#928374
hi DiagnosticUnnecessary         cterm=undercurl ctermfg=none ctermbg=none guisp=#98971a
hi DiagnosticDeprecated          cterm=undercurl ctermfg=none ctermbg=none guisp=#d79921

" --------------------------------------
" telescope
" --------------------------------------
hi TelescopeMatching             cterm=none        ctermfg=1        ctermbg=none
hi TelescopeBorder               cterm=none        ctermfg=8        ctermbg=none
hi TelescopePromptCounter        cterm=none        ctermfg=8        ctermbg=none
hi TelescopeMultiIcon            cterm=none        ctermfg=2        ctermbg=none
