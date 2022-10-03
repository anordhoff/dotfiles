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

" enable or disable sharing mode
" TODO: opening netrw after enabling sharing mode breaks cursorline/cursorcolumn
" TODO: dirvish?
function init#sharing(enable)
  if a:enable
    setlocal cursorline
    setlocal cursorcolumn
    augroup sharing
      autocmd!
      autocmd WinEnter * if &ft != 'netrw' | setlocal cursorline cursorcolumn | endif
      autocmd WinLeave * if &ft != 'netrw' | setlocal nocursorline nocursorcolumn | endif
    augroup END
  else
    setlocal nocursorline
    setlocal nocursorcolumn
    augroup sharing
      autocmd!
    augroup END
  endif
endfunction

" get highlight group under the cursor
function init#syngroup()
  for l:i1 in synstack(line('.'), col('.'))
    let l:i2 = synIDtrans(l:i1)
    echo synIDattr(l:i1, 'name') '->' synIDattr(l:i2, 'name')
  endfor
endfunction

" clear registers
function init#clearregisters(chars)
  for l:char in split(a:chars, '\zs')
    :call setreg(l:char, [])
  endfor
  echo "Successfully cleared registers '" . a:chars .
    \ "'. Execute :wshada! to persist changes"
endfunction

" toggle the notebook
function init#togglenotes(dir)
  if !exists('t:notesbuf')
    let t:notesbuf = 0
  endif
  if !exists('t:noteswin')
    let t:noteswin = 0
  endif

  " toggle the notes window, saving the currently open buffer
  if win_gotoid(t:noteswin)
    let t:notesbuf = bufnr('%')
    hide
  else
    try
      exec 'sbuffer ' . t:notesbuf
    catch
      exec 'split ' . a:dir
      let t:notesbuf = bufnr('%')
    endtry
    let t:noteswin = win_getid()
  endif
endfunction

" toggle a horizontal/vertical terminal split
function init#toggleterm(vsplit)
  if !exists('t:termbuf')
    let t:termbuf = 0
  endif
  if !exists('t:termwin')
    let t:termwin = 0
  endif

  " if a terminal window is open, hide it; else, (re)open a terminal window
  if bufname(winbufnr(t:termwin)) =~ '^term://' && win_gotoid(t:termwin)
    hide
  else
    try
      if a:vsplit
        exec 'vertical sbuffer ' . t:termbuf
      else
        exec 'sbuffer ' . t:termbuf
      endif
      startinsert!
    catch
      if a:vsplit
        exec 'vsplit +term'
      else
        exec 'split +term'
      endif
      let t:termbuf = bufnr('%')
    endtry
    let t:termwin = win_getid()
  endif
endfunction
