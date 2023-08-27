" edit the current file's alternate file
" nnoremap <silent> <buffer> <leader>aa :call AlternateFile('edit')<cr>
" nnoremap <silent> <buffer> <leader>as :call AlternateFile('split')<cr>
" nnoremap <silent> <buffer> <leader>av :call AlternateFile('vsplit')<cr>
" nnoremap <silent> <buffer> <leader>at :call AlternateFile('tabnew')<cr>
" if exists('*AlternateFile')
"   finish
" endif
" function AlternateFile(n)
"   if stridx(expand("%:t"), '_test') == -1
"     exec a:n ' ' . expand("%:r") . '_test.go'
"   else
"     exec a:n ' ' . expand("%:h") . '/' . substitute(expand("%:t"), '_test', '', '')
"   endif
" endfunction
