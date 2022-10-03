setlocal list
setlocal listchars=tab:\ \ ,trail:-

" don't show trailing spaces while in insert mode
augroup listchars
  autocmd!
  autocmd InsertEnter * setlocal listchars-=trail:-
  autocmd InsertLeave * setlocal listchars+=trail:-
augroup END

" enable automatic folding
setlocal foldmethod=syntax

" edit the current file's alternate file (TODO)
" nnoremap <silent> <buffer> <leader>ee :call go#alternate('edit')<CR>
" nnoremap <silent> <buffer> <leader>es :call go#alternate('split')<CR>
" nnoremap <silent> <buffer> <leader>ev :call go#alternate('vsplit')<CR>
" nnoremap <silent> <buffer> <leader>et :call go#alternate('tabnew')<CR>
