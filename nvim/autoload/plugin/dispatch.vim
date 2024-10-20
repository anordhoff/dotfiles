function plugin#dispatch#run(bang, args)
  if a:bang
    let bang = '!'
  else
    let bang = ''
  endif
  if len(a:args)
    let args = join(map(split(a:args, '\ze[<%#]'), 'expand(v:val)'), '')
  else
    let args = ''
  endif
  exec 'Dispatch' .. bang ' -compiler=stdout ' .. args
endfunction

function plugin#dispatch#print_stdout_focus()
  let [what, how] = dispatch#focus()
  echo how .. ' is ' .. what .. ' -compiler=stdout'
endfunction
