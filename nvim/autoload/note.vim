" toggle the notebook
function note#togglenotes(dir)
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
