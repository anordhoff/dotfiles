function init#syngroup()
  for i1 in synstack(line('.'), col('.'))
    let i2 = synIDtrans(i1)
    echo synIDattr(i1, 'name') '->' synIDattr(i2, 'name')
  endfor
  echo "Use :Inspect for now on"
endfunction

function init#clear_register(chars)
  for char in split(a:chars, '\zs')
    call setreg(char, [])
  endfor
  echo "Successfully cleared registers '" .. a:chars ..
    \ "'. Execute :wshada! to persist changes"
endfunction
