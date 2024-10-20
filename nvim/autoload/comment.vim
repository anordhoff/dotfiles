function comment#comment(start, end)
  exec a:start .. ',' .. a:end .. 'normal gcc'
  exec 'normal! ' .. a:start .. 'G'
endfunction

function comment#duplicate(start, end)
  exec a:start .. ',' .. a:end .. 'copy ' .. a:end
  exec a:start .. ',' .. a:end .. 'normal gcc'
  exec 'normal! ' .. a:end .. 'Gj'
endfunction

function comment#comment_range(start, end)
  call comment#comment(a:start, a:end)
  exec 'normal! 0'
endfunction

function comment#duplicate_lines(count)
  call comment#duplicate(line('.'), line('.') + a:count - 1)
  silent! call repeat#set("gzz", a:count)
endfunction

function comment#duplicate_visual(start, end)
  let start = line(a:start)
  let end = line(a:end)
  call comment#duplicate(start, end)
  silent! call repeat#set("gzz", end - start + 1)
endfunction

function comment#duplicate_operator(type)
  call comment#duplicate(line("'["), line("']"))
  exec 'normal! 0'
endfunction

function comment#duplicate_range(start, end)
  call comment#duplicate(a:start, a:end)
  exec 'normal! 0'
endfunction
