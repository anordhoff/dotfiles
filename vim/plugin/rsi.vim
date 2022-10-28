" implement readline C-k (overrides builtin C-k)
inoremap <C-k> <C-o>D
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
