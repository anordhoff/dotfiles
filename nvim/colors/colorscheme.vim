" colorscheme.vim - a minimalistic colorscheme
" based on https://github.com/ggalindezb/vim_colorscheme_template

" --------------------------------
" set background=dark
" - or ---------------------------
" set background=light
" --------------------------------

highlight clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'colorscheme'

"----------------------------------------------------------------
" General settings                                              |
"----------------------------------------------------------------

" --------------------------------
" Editor settings
" --------------------------------
hi Normal			cterm=none	ctermfg=15	ctermbg=0
hi Cursor			cterm=none	ctermfg=none	ctermbg=none
hi CursorLine			cterm=none	ctermfg=none	ctermbg=8
hi! link CursorLineNr		Normal
hi! link CursorColumn		CursorLine
hi! link ColorColumn		CursorLine

" -----------------
" - Number column -
" -----------------
hi LineNr			cterm=none	ctermfg=7	ctermbg=none
hi SignColumn			cterm=none	ctermfg=none	ctermbg=none
hi! link FoldColumn		SignColumn
hi! link Folded			Comment

" -------------------------
" - Window/Tab delimiters -
" -------------------------
hi VertSplit			cterm=none	ctermfg=8	ctermbg=none
hi TabLine			cterm=none	ctermfg=7	ctermbg=8
hi TabLineFill			cterm=none	ctermfg=7	ctermbg=8
hi TabLineSel			cterm=none	ctermfg=15	ctermbg=8

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
hi! link Directory		Normal
hi Search			cterm=none	ctermfg=0	ctermbg=2
hi IncSearch			cterm=none	ctermfg=0	ctermbg=4

" -----------------
" - Prompt/Status -
" -----------------
hi StatusLine			cterm=none	ctermfg=15	ctermbg=8
hi StatusLineNC			cterm=none	ctermfg=7	ctermbg=8
" TODO: WildMenu, Question, Title, MoreMsg?
hi WildMenu			cterm=none	ctermfg=none	ctermbg=none
hi Question			cterm=none	ctermfg=none	ctermbg=none
hi Title			cterm=none	ctermfg=none	ctermbg=none
hi ModeMsg			cterm=none	ctermfg=none	ctermbg=none
hi MoreMsg			cterm=none	ctermfg=none	ctermbg=none

" --------------
" - Visual aid -
" --------------
hi MatchParen			cterm=none	ctermfg=4	ctermbg=none
hi Visual			cterm=none	ctermfg=none	ctermbg=8
" TODO: VisualNOS?
hi VisualNOS			cterm=none	ctermfg=none	ctermbg=none
hi NonText			cterm=none	ctermfg=7	ctermbg=none
hi EndOfBuffer			cterm=none	ctermfg=7	ctermbg=none
hi Conceal			cterm=none	ctermfg=none	ctermbg=none

hi Todo				cterm=none	ctermfg=4	ctermbg=none
hi Underlined			cterm=underline	ctermfg=none	ctermbg=none
hi Error			cterm=none	ctermfg=1	ctermbg=none
hi! link ErrorMsg		Error
hi WarningMsg			cterm=none	ctermfg=3	ctermbg=none
" TODO: Ignore, SpecialKey?
hi Ignore			cterm=none	ctermfg=none	ctermbg=none
hi SpecialKey			cterm=none	ctermfg=none	ctermbg=none

" --------------------------------
" Variable types
" --------------------------------
hi String			cterm=none	ctermfg=4	ctermbg=none
hi! link StringDelimiter	String
hi! link Constant		Normal
hi! link Character		Constant
hi! link Number			Constant
hi! link Boolean		Constant
hi! link Float			Constant

hi! link Identifier		Constant
hi! link Function		Constant

" --------------------------------
" Language constructs
" --------------------------------
hi Comment			cterm=none	ctermfg=7	ctermbg=none
hi! link Statement		Normal
hi! link Conditional		Statement
hi! link Repeat			Statement
hi! link Label			Statement
hi! link Operator		Statement
hi! link Keyword		Statement
hi! link Exception		Statement

hi! link Special		Normal
hi! link SpecialChar		Special
hi! link Tag			Special
hi! link Delimiter		Special
hi! link SpecialComment		Special
hi! link Debug			Special

" ----------
" - C like -
" ----------
hi! link PreProc		Normal
hi! link Include		PreProc
hi! link Define			PreProc
hi! link Macro			PreProc
hi! link PreCondit		PreProc

hi! link Type			Normal
hi! link StorageClass		Type
hi! link Structure		Type
hi! link Typedef		Type

" --------------------------------
" Diff
" --------------------------------
hi DiffAdd			cterm=none	ctermfg=2	ctermbg=none
hi DiffChange			cterm=none	ctermfg=3	ctermbg=none
hi DiffDelete			cterm=none	ctermfg=1	ctermbg=none
hi! link DiffText		Normal

" --------------------------------
" Completion menu
" --------------------------------
hi Pmenu			cterm=none	ctermfg=15	ctermbg=8
hi PmenuSel			cterm=none	ctermfg=4	ctermbg=8
hi PmenuSbar			cterm=none	ctermfg=15	ctermbg=8
hi PmenuThumb			cterm=none	ctermfg=15	ctermbg=8

" --------------------------------
" Spelling
" --------------------------------
hi SpellBad			cterm=none	ctermfg=1	ctermbg=none
hi! link SpellCap		SpellBad
hi! link SpellLocal		SpellBad
hi! link SpellRare		SpellBad

" --------------------------------
" Quickfix
" --------------------------------
hi QuickFixLine			cterm=none	ctermfg=4	ctermbg=none
hi qfLineNr			cterm=none	ctermfg=7	ctermbg=none

" --------------------------------
" Neovim
" --------------------------------
hi! link NormalFloat		Normal
hi FloatBorder			cterm=none	ctermfg=7	ctermbg=none


"--------------------------------------------------------------------
" Languages                                                         |
"--------------------------------------------------------------------

" --------------------------------
" json
" --------------------------------
hi jsonKeyword			cterm=none	ctermfg=5	ctermbg=none
hi! link jsonString		Normal

" --------------------------------
" yaml
" --------------------------------
hi yamlBlockMappingKey		cterm=none	ctermfg=5	ctermbg=none

" --------------------------------
" go
" --------------------------------
hi goSpecialString		cterm=none	ctermfg=2	ctermbg=none


"--------------------------------------------------------------------
" Plugins                                                           |
"--------------------------------------------------------------------

" --------------------------------
" nvim-lspconfig
" --------------------------------
hi DiagnosticError		cterm=none	ctermfg=1	ctermbg=none
hi DiagnosticWarn		cterm=none	ctermfg=3	ctermbg=none
hi DiagnosticInfo		cterm=none	ctermfg=4	ctermbg=none
hi DiagnosticHint		cterm=none	ctermfg=7	ctermbg=none

" --------------------------------
" vim-signature
" --------------------------------
hi SignatureMarkText		cterm=none	ctermfg=15	ctermbg=none

" --------------------------------
" vim-gitgutter
" --------------------------------
" hi GitGutterAdd			cterm=none	ctermfg=2	ctermbg=none
" hi GitGutterChange		cterm=none	ctermfg=3	ctermbg=none
" hi GitGutterDelete		cterm=none	ctermfg=1	ctermbg=none
hi GitGutterAdd			cterm=none	ctermfg=7	ctermbg=none
hi GitGutterChange		cterm=none	ctermfg=7	ctermbg=none
hi GitGutterDelete		cterm=none	ctermfg=7	ctermbg=none

" --------------------------------
" telescope
" --------------------------------
hi TelescopePrompt		cterm=none	ctermfg=none	ctermbg=none
hi TelescopePromptBorder	cterm=none	ctermfg=none	ctermbg=none
hi TelescopeResultsConstant	cterm=none	ctermfg=none	ctermbg=none
hi TelescopeResultsVariable	cterm=none	ctermfg=none	ctermbg=none
hi TelescopeResultsFunction	cterm=none	ctermfg=none	ctermbg=none

" --------------------------------
" vim-go
" --------------------------------
hi goCoverageCovered		cterm=none	ctermfg=3	ctermbg=none
hi goCoverageUncover		cterm=none	ctermfg=1	ctermbg=none
