let g:qf_save_win_view = 0
let g:qf_auto_resize = 0
let g:qf_auto_quit = 0
let g:qf_custom_mappings = 1

" NOTE: there's a bug (https://github.com/romainl/vim-qf/issues/134)
" let g:qf_shorten_path = 3

nnoremap <leader>q <plug>(qf_qf_toggle)
nnoremap <leader>l <cmd>call plugin#qf#location_list()<cr>
