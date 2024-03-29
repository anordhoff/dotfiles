" enable copilot for specific filetypes
" let g:copilot_filetypes = {
"   \ '*': v:false,
"   \ 'go': v:true,
"   \ 'json': v:true,
"   \ 'python': v:true,
"   \ 'yaml': v:true,
"   \ }

inoremap <c-n> <Plug>(copilot-next)
inoremap <c-p> <Plug>(copilot-previous)
