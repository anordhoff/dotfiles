setlocal list
setlocal listchars=tab:\ \ ,trail:-
setlocal commentstring=#\ %s

" don't show trailing spaces while in insert mode
augroup listchars
  autocmd!
  autocmd InsertEnter * setlocal listchars-=trail:-
  autocmd InsertLeave * setlocal listchars+=trail:-
augroup END
