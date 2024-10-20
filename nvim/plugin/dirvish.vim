" sort directories first
let g:dirvish_mode = ':sort ,^.*[\/],'

" open the current working directory
nnoremap <silent> _ <cmd>Dirvish .<cr>

" open the [count]th parent directory in a new window
nnoremap <silent> <leader>S <plug>(dirvish_split_up)
nnoremap <silent> <leader>V <plug>(dirvish_vsplit_up)

augroup dirvish_config
  autocmd!

  " use dirvish instead of netrw when opening a directory with vim
  autocmd VimEnter * if exists('#FileExplorer') | exe 'au! FileExplorer *' | endif
augroup END
