let g:qf_mapping_ack_style = 1
let g:qf_save_win_view = 0
let g:qf_shorten_path = 3

nnoremap <leader>q <plug>(qf_qf_toggle)
nnoremap <silent> <leader>l :call LocationList()<cr>

" prevent errors from requiring an additional key to continue
function LocationList()
  try
    :execute "normal \<plug>(qf_loc_toggle)"
  catch 'E776'
    echohl ErrorMsg | echo 'E776: No location list' | echohl None
  endtry
endfunction

augroup qf_config
  autocmd!

  autocmd Filetype qf nnoremap <silent><buffer> [[ <plug>(qf_older)
  autocmd Filetype qf nnoremap <silent><buffer> ]] <plug>(qf_newer)
augroup END
