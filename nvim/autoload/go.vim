function go#alternate_file(n)
  if stridx(expand("%:t"), '_test') == -1
    exec a:n ' ' . expand("%:r") . '_test.go'
  else
    exec a:n ' ' . expand("%:h") . '/' . substitute(expand("%:t"), '_test', '', '')
  endif
endfunction
