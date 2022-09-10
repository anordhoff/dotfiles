" toggle a horizontal/vertical terminal split
function term#toggleterm(vsplit)
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
