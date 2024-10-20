" function tabline#tabline()
"   let line = '%#StatusLine#' .. ' ' .. '%#TabLine#'
"   for tab in range(tabpagenr('$'))
"     if tab + 1 == tabpagenr()
"       let line ..= '%#TabLineSel#'
"     else
"       let line ..= '%#TabLine#'
"     endif
"     let line ..= ' %{tabline#tablabel(' .. (tab + 1) .. ')} '
"   endfor
"   let line ..= '%#TabLineFill#%T' .. '%=%#StatusLine#' .. ' '
"   return line
" endfunction
"
" function tabline#tablabel(n)
"   let winnr = tabpagewinnr(a:n)
"   let buflist = tabpagebuflist(a:n)
"   let bufname = bufname(buflist[winnr - 1])
"   let filetype = getbufvar(buflist[winnr - 1], '&filetype')
"   if bufname == ''
"     return '[No Name]'
"   elseif bufname =~ '/nvim/runtime/doc/'
"     return 'help'
"   elseif filetype == 'netrw'
"     return 'netrw'
"   elseif filetype == 'dirvish'
"     return 'dirvish'
"   elseif bufname =~ '^term://'
"     return 'terminal'
"   else
"     return bufname
"   endif
" endfunction
