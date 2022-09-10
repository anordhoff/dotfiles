" maximize (toggle) the current window
function init#togglemaximizewindow()
  if !exists('t:maximized')
    let t:maximized = 0
  endif
  if t:maximized
    execute "normal! \<C-w>="
    let t:maximized = 0
  else
    resize
    vertical-resize
    let t:maximized = 1
  endif
endfunction

" toggle the quickfix list window
function init#togglequickfixlist()
  if getqflist({'winid': 0}).winid
    cclose
  else
    copen
  endif
endfunction

" toggle the location list window
function init#togglelocationlist()
  try
    if getloclist(0, {'winid': 0}).winid
      lclose
    else
      lopen
    endif
  catch 'E776'
    echohl ErrorMsg | echo 'E776: No location list' | echohl None
  endtry
endfunction

" toggle sharing mode
function init#togglesharing()
  if g:sharing
    setlocal nocursorline
    setlocal nocursorcolumn
    let g:sharing = 0
  else
    setlocal cursorline
    setlocal cursorcolumn
    let g:sharing = 1
  endif
endfunction

" get highlight group under the cursor
function init#syngroup()
  for l:i1 in synstack(line('.'), col('.'))
    let l:i2 = synIDtrans(l:i1)
    echo synIDattr(l:i1, 'name') '->' synIDattr(l:i2, 'name')
  endfor
endfunction
