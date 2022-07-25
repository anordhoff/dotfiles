" ----------------------------------------------------------
" general settings
" ----------------------------------------------------------

highlight clear
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
hi! link Character               Constant
hi! link Number                  Constant
hi! link Boolean                 Constant
hi! link Float                   Constant

hi Identifier                    cterm=none        ctermfg=7        ctermbg=none
hi! link Function                Identifier

hi Statement                     cterm=none        ctermfg=7        ctermbg=none
hi! link Conditional             Statement
hi! link Repeat                  Statement
hi! link Label                   Statement
hi! link Operator                Statement
hi! link Keyword                 Statement
hi! link Exception               Statement

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
hi Cursor                        cterm=none        ctermfg=0        ctermbg=8
hi! link TermCursor              Cursor
hi TermCursorNC                  cterm=none        ctermfg=0        ctermbg=14
hi CursorLine                    cterm=none        ctermfg=none     ctermbg=10
hi CursorLineNr                  cterm=none        ctermfg=14       ctermbg=none
hi! link CursorColumn            CursorLine
hi! link ColorColumn             CursorLine

" --------------------------------------
" number column
" --------------------------------------
hi LineNr                        cterm=none        ctermfg=14       ctermbg=none
hi SignColumn                    cterm=none        ctermfg=7        ctermbg=none
hi FoldColumn                    cterm=none        ctermfg=7        ctermbg=none
hi Folded                        cterm=none        ctermfg=14       ctermbg=none

" --------------------------------------
" window/tab delimiters
" --------------------------------------
hi VertSplit                     cterm=none        ctermfg=14       ctermbg=none
hi TabLine                       cterm=none        ctermfg=7        ctermbg=11
hi TabLineFill                   cterm=none        ctermfg=none     ctermbg=11
hi TabLineSel                    cterm=none        ctermfg=5        ctermbg=11

" --------------------------------------
" prompt / status
" --------------------------------------
hi StatusLine                    cterm=none        ctermfg=0        ctermbg=8
hi StatusLineNC                  cterm=none        ctermfg=7        ctermbg=11
hi WildMenu                      cterm=none        ctermfg=4        ctermbg=11
hi Question                      cterm=none        ctermfg=7        ctermbg=none
hi Title                         cterm=none        ctermfg=7        ctermbg=none
hi ModeMsg                       cterm=none        ctermfg=7        ctermbg=none
hi MoreMsg                       cterm=none        ctermfg=7        ctermbg=none

" --------------------------------------
" file navigation / searching
" --------------------------------------
hi Directory                     cterm=none        ctermfg=7        ctermbg=none
hi Search                        cterm=none        ctermfg=0        ctermbg=4
hi IncSearch                     cterm=none        ctermfg=0        ctermbg=5

" --------------------------------------
" completion menu
" --------------------------------------
hi Pmenu                         cterm=none        ctermfg=7        ctermbg=12
hi PmenuSel                      cterm=none        ctermfg=5        ctermbg=12
hi PmenuSbar                     cterm=none        ctermfg=none     ctermbg=12
hi PmenuThumb                    cterm=none        ctermfg=none     ctermbg=8

" --------------------------------------
" quickfix
" --------------------------------------
hi QuickFixLine                  cterm=none        ctermfg=5        ctermbg=none
hi qfLineNr                      cterm=none        ctermfg=8        ctermbg=none
hi qfError                       cterm=none        ctermfg=8        ctermbg=none

" --------------------------------------
" visual aid
" --------------------------------------
hi MatchParen                    cterm=none        ctermfg=5        ctermbg=none
hi Visual                        cterm=none        ctermfg=7        ctermbg=15
hi VisualNOS                     cterm=none        ctermfg=7        ctermbg=15
hi NonText                       cterm=none        ctermfg=2        ctermbg=none
hi Whitespace                    cterm=none        ctermfg=3        ctermbg=none
hi EndOfBuffer                   cterm=none        ctermfg=14       ctermbg=none
hi Conceal                       cterm=none        ctermfg=2        ctermbg=none
hi SpecialKey                    cterm=none        ctermfg=2        ctermbg=none

hi Underlined                    cterm=underline   ctermfg=none     ctermbg=none
hi Ignore                        cterm=none        ctermfg=3        ctermbg=none
hi Error                         cterm=none        ctermfg=1        ctermbg=none
hi! link ErrorMsg                Error
hi WarningMsg                    cterm=none        ctermfg=3        ctermbg=none
hi Todo                          cterm=none        ctermfg=3        ctermbg=none

" --------------------------------------
" diff
" --------------------------------------
hi DiffAdd                       cterm=none        ctermfg=7        ctermbg=13
hi DiffChange                    cterm=none        ctermfg=none     ctermbg=11
hi DiffDelete                    cterm=none        ctermfg=1        ctermbg=none
hi DiffText                      cterm=none        ctermfg=7        ctermbg=9

" --------------------------------------
" spelling
" --------------------------------------
hi SpellBad                      cterm=none        ctermfg=3        ctermbg=none
hi! link SpellCap                SpellBad
hi! link SpellLocal              SpellBad
hi! link SpellRare               SpellBad

" --------------------------------------
" neovim
" --------------------------------------
hi NormalFloat                   cterm=none        ctermfg=none     ctermbg=12
hi FloatBorder                   cterm=none        ctermfg=8        ctermbg=none


" ----------------------------------------------------------
" languages
" ----------------------------------------------------------

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

" --------------------------------------
" make
" --------------------------------------
hi makeTarget                    cterm=none        ctermfg=6        ctermbg=none
hi makeSpecTarget                cterm=none        ctermfg=5        ctermbg=none

" --------------------------------------
" vimscript
" --------------------------------------
hi vimCommentTitle               cterm=none        ctermfg=3        ctermbg=none

" --------------------------------------
" yaml
" --------------------------------------
hi yamlBlockMappingKey           cterm=none        ctermfg=6        ctermbg=none


" ----------------------------------------------------------
" plugins
" ----------------------------------------------------------

" --------------------------------------
" dirvish
" --------------------------------------
hi DirvishPathTail               cterm=none        ctermfg=4        ctermbg=none
hi DirvishArg                    cterm=none        ctermfg=5        ctermbg=none

" --------------------------------------
" gitsigns.nvim
" --------------------------------------
hi GitSignsAdd                   cterm=none        ctermfg=2        ctermbg=none
hi GitSignsChange                cterm=none        ctermfg=3        ctermbg=none
hi GitSignsDelete                cterm=none        ctermfg=1        ctermbg=none

" --------------------------------------
" leap.nvim
" --------------------------------------
hi LeapMatch                     cterm=none        ctermfg=7        ctermbg=none
hi LeapLabelPrimary              cterm=none        ctermfg=7        ctermbg=none
hi LeapLabelSecondary            cterm=none        ctermfg=5        ctermbg=none
hi LeapBackdrop                  cterm=none        ctermfg=14       ctermbg=none

" --------------------------------------
" nvim-lspconfig
" --------------------------------------
hi DiagnosticError               cterm=none        ctermfg=7        ctermbg=none
hi DiagnosticWarn                cterm=none        ctermfg=7        ctermbg=none
hi DiagnosticInfo                cterm=none        ctermfg=7        ctermbg=none
hi DiagnosticHint                cterm=none        ctermfg=7        ctermbg=none
hi DiagnosticSignError           cterm=none        ctermfg=1        ctermbg=none
hi DiagnosticSignWarn            cterm=none        ctermfg=3        ctermbg=none
hi DiagnosticSignInfo            cterm=none        ctermfg=4        ctermbg=none
hi DiagnosticSignHint            cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" telescope.nvim
" --------------------------------------
hi TelescopeMatching             cterm=none        ctermfg=4        ctermbg=none
hi TelescopeBorder               cterm=none        ctermfg=8        ctermbg=none
hi TelescopePromptCounter        cterm=none        ctermfg=7        ctermbg=none
