" " assemble the custom statusline for most filetypes
" function statusline#statusline(winid)
"   let statusline  = ' ' .. statusline#background(a:winid) " left padding; set statusline background color
"   let statusline ..= ' [%n]  '                            " buffer number
"   let statusline ..= '%f'                                 " filepath
"   let statusline ..= '%{statusline#git_branch()}  '       " git branch
"   let statusline ..= '%{statusline#noplugin_flag()}'      " plugin flag
"   let statusline ..= '%H%W%R%M'                           " help/preview/read-only/modified flags
"   let statusline ..= '%=   %c%V  :  %2l/%L'               " byte index, virtual column number; line number
"   let statusline ..= '%{statusline#filetype()}'           " filetype
"   let statusline ..= '%* '                                " reset background color; right padding
"   return statusline
" endfunction
"
" " set background depending on whether the window is active
" function statusline#background(winid)
"   return a:winid == win_getid() ? '%#StatusLineActive#' : '%#StatusLineInactive#'
" endfunction
"
" " correct padding when there is no filetype
" function statusline#filetype()
"   return &filetype == '' ? ' ' : '  [' .. &filetype .. '] '
" endfunction
"
" " show the git branch if plugins are enabled
" function statusline#git_branch()
"   if !&loadplugins || empty(FugitiveGitDir(bufnr('')))
"     return ''
"   endif
"   let branch = substitute(substitute(FugitiveStatusline(), '^[Git(', '', ''), ')]$', '', '')
"   if strlen(branch .. expand('%')) > 56
"     return '  (' .. strpart(branch, 0, 53 - strlen(expand('%'))) .. '...)'
"   else
"     return '  (' .. branch .. ')'
"   endif
" endfunction
"
" " noplugin flag if running with --noplugin set
" function statusline#noplugin_flag()
"   return !&loadplugins ? 'NP' : ''
" endfunction
"
" " return the title of the quickfix window
" function statusline#quickfix_title()
"   return exists('w:quickfix_title') ? w:quickfix_title .. '  ' : ''
" endfunction
"
" " quickfix list and location list statusline
" function statusline#quickfix_list_statusline(winid)
"   return ' ' .. statusline#background(a:winid) .. " [%l/%L lines]  %{statusline#quickfix_title()}%=%q %* "
" endfunction
"
" " netrw statusline
" function statusline#netrw_statusline(winid)
"   return ' ' .. statusline#background(a:winid) .. ' [%n]  %l/%L lines%=[netrw] %* '
" endfunction
"
" " terminal window statusline
" function statusline#term_statusline(winid)
"   return ' ' .. statusline#background(a:winid) .. ' [%n]  %{statusline#term_shell()}%{statusline#term_mode()}  %{statusline#noplugin_flag()}%R%=[term] %* '
" endfunction
"
" " return shell used by terminal
" function statusline#term_shell()
"   return split(b:term_title, ':')[-1]
" endfunction
"
" " set 'insert' flag if terminal buffer is in 'terminal' mode
" function statusline#term_mode()
"   " TODO: why is one of the spaces being dropped
"   " return mode() == 't' ? '  (insert)' : ''
"   return mode() == 't' ? '   (insert)' : ''
" endfunction
