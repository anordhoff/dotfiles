" TODO: duplicate with a motion/operator

" duplicate the current line
nnoremap gcd :Commentary<Bar>copy .<Bar>Commentary<CR>

" duplicate visually selected lines
xnoremap gd :copy '><Bar>'<,'>Commentary<CR>
