function! Duplicate(start, end)
  exec a:start . ',' . a:end . 'copy ' . a:end
  exec a:start . ',' . a:end . 'Commentary'
  exec 'normal! ' . a:end . 'Gj'
endfunction

" duplicate a count of lines
nnoremap <silent> gzz :<c-u>call DuplicateLines(v:count1)<cr>
function! DuplicateLines(count)
  call Duplicate(line('.'), line('.') + a:count - 1)
  silent! call repeat#set("gzz", a:count)
endfunction

" duplicate the highlighted lines
xnoremap <silent> gz :<c-u>call DuplicateVisual("'<", "'>")<cr>
function! DuplicateVisual(start, end)
  let l:start = line(a:start)
  let l:end = line(a:end)
  call Duplicate(l:start, l:end)
  silent! call repeat#set("gzz", l:end - l:start + 1)
endfunction

" duplicate lines that a motion moves over
nnoremap <silent> gz :set opfunc=DuplicateOperator<cr>g@
function! DuplicateOperator(type)
  call Duplicate(line("'["), line("']"))
  exec 'normal! 0'
endfunction

" duplicate a range of lines
command -range Duplicate call DuplicateRange(<line1>, <line2>)
function! DuplicateRange(start, end)
  call Duplicate(a:start, a:end)
  exec 'normal! 0'
endfunction
