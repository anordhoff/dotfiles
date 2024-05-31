" disable copilot for certain filetypes
" let g:copilot_filetypes = {
"   \ 'xml': v:false,
"   \ }

" accept the current suggestion with ctrl-h
let g:copilot_no_tab_map = v:true
inoremap <silent><script><expr> <c-h> copilot#Accept("")

" use ctrl-n and ctrl-p to cycle through copilot suggestions
inoremap <c-n> <plug>(copilot-next)
inoremap <c-p> <plug>(copilot-previous)
