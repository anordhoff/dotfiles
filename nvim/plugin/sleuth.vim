" disable neovim's built in editorconfig in favor or sleuth
let g:editorconfig = v:false

" disable vim-sleuth for go files (softtabstop=-1 breaks gofmt)
" TODO: https://github.com/tpope/vim-sleuth/issues/83
" let g:sleuth_go_heuristics = 0
" let g:sleuth_editorconfig_overrides = {
"     \ expand('$HOME/dragon/compliance-advisor'): '',
"     \ }

" let g:sleuth_editorconfig_overrides = {
"     \ expand('$HOMEBREW_PREFIX/.editorconfig'): '',
"     \ }
