" toggle a horizontal/vertical terminal split
function term#Toggle(vsplit)
  if !exists('t:termbuf')
    let t:termbuf = 0
  endif
  if !exists('t:termwin')
    let t:termwin = 0
  endif

  " if a terminal window is open, hide it; else, (re)open a terminal window
  if bufname(winbufnr(t:termwin)) =~ '^term://' && win_gotoid(t:termwin)
    hide
    wincmd p
  else
    try
      if a:vsplit
        exec 'botright vertical sbuffer ' .. t:termbuf
      else
        exec 'botright sbuffer ' .. t:termbuf
      endif
      " startinsert!
    catch
      if a:vsplit
        exec 'botright vsplit +term'
      else
        exec 'botright split +term'
      endif
      " startinsert!
    endtry
    let t:termwin = win_getid()
  endif
endfunction

" switch between open terminal window and previous window
function term#Focus()
  if !exists('t:termbuf') || !exists('t:termwin') || bufwinid(t:termbuf) == -1
      echohl ErrorMsg | echo 'No terminal window' | echohl None
      return
  endif
  if win_getid() == t:termwin
    wincmd p
  else
    call win_gotoid(t:termwin)
    " startinsert!
  endif
endfunction
