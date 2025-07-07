function notebook#Project(dir)
  if !exists('t:notesbuf')
    let t:notesbuf = 0
  endif
  if !exists('t:noteswin')
    let t:noteswin = 0
  endif

  " toggle the project notes window, saving the currently open buffer
  if win_gotoid(t:projectwin)
    let t:projectbuf = bufnr('%')
    hide
  else
    try
      exec 'botright sbuffer ' .. t:projectbuf
    catch
      let project = split(getcwd(), '/')[-1]
      exec 'botright split ' .. a:dir .. project .. '.md'
      let t:notesbuf = bufnr('%')
    endtry
    let t:noteswin = win_getid()
  endif
endfunction

function notebook#Todo(file)
  if !exists('t:todobuf')
    let t:todobuf = 0
  endif
  if !exists('t:todowin')
    let t:todowin = 0
  endif

  " toggle the todo notes window, saving the currently open buffer
  if win_gotoid(t:todowin)
    let t:todobuf = bufnr('%')
    hide
  else
    try
      exec 'botright sbuffer ' .. t:todobuf
    catch
      exec 'botright split ' .. a:file
      let t:todobuf = bufnr('%')
    endtry
    let t:todowin = win_getid()
  endif
endfunction
