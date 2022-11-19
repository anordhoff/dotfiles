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

" edit the current file's alternate file
nnoremap <silent> <buffer> <leader>aa :call AlternateFile('edit')<CR>
nnoremap <silent> <buffer> <leader>as :call AlternateFile('split')<CR>
nnoremap <silent> <buffer> <leader>av :call AlternateFile('vsplit')<CR>
nnoremap <silent> <buffer> <leader>at :call AlternateFile('tabnew')<CR>

if exists('*AlternateFile')
  finish
endif
function AlternateFile(n)
  if stridx(expand("%:t"), '_test') == -1
    exec a:n ' ' . expand("%:r") . '_test.go'
  else
    exec a:n ' ' . expand("%:h") . '/' . substitute(expand("%:t"), '_test', '', '')
  endif
endfunction
