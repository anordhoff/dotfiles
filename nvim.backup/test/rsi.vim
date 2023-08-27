" implement readline ctrl-k (overrides builtin ctrl-k)

" insert mode mapping is shadowed by nvim-lspconfig <c-k> mapping
inoremap <expr> <c-k> col('.') > strlen(getline('.')) ? '' : '<c-o>D'

" ctrl-k in command mode
cnoremap <c-k> <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<cr>
