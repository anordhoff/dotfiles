function quickfix#ToggleQuickfixlist()
  if getqflist({'winid': 0}).winid
    let g:quickfix_height = winheight(getqflist({'winid' : 1}).winid)
    cclose
  else
    execute 'botright copen ' .. g:quickfix_height
    wincmd p
  endif
endfunction

function quickfix#ToggleLocationlist()
  try
    if getloclist(0, {'winid': 0}).winid
      let b:locationlist_height = winheight(getloclist(0, {'winid' : 1}).winid)
      lclose
    else
      execute 'lopen ' .. b:locationlist_height
      wincmd p
    endif
  catch 'E776'
    echohl ErrorMsg | echo 'E776: No location list' | echohl None
  endtry
endfunction
