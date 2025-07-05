if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" https://github.com/romainl/vim-qf/blob/master/after/ftplugin/qf.vim
" custom mappings available only in location/quickfix windows
if exists("g:qf_custom_mappings")

  " are we in a location list or a quickfix list?
  let b:qf_isLoc = get(get(getwininfo(win_getid()), 0, {}), 'loclist', 0)

  " is the location list or quickfix list at the bottom of the window?
  let qf_at_bottom = (b:qf_isLoc == 1 && get(g:, 'qf_loclist_window_bottom', 1))
    \ || (b:qf_isLoc == 0 && get(g:, 'qf_window_bottom', 1))

  " open entry in a new vertical window.
  if qf_at_bottom
    nnoremap <silent><expr><buffer> <c-v> &splitright ? "\<c-w>\<cr>\<c-w>L\<c-w>p\<c-w>J\<c-w>p" : "\<c-w>\<cr>\<c-w>H\<c-w>p\<c-w>J\<c-w>p"
  else
    " don't move quickfix to bottom if qf_loclist_window_bottom is 0
    nnoremap <silent><expr><buffer> <c-v> &splitright ? "\<c-w>\<cr>\<c-w>L" : "\<c-w>\<cr>\<c-w>H"
  endif

  if qf_at_bottom && &splitbelow
    " open entry in a new horizontal window and move quickfix to bottom
    nnoremap <silent><buffer> <c-s> <c-w><cr><c-w>p<c-w>J<c-w>p

    " preview entry under the cursor and move quickfix to bottom
    nnoremap <silent><buffer> p :call qf#preview#PreviewFileUnderCursor()<cr><c-w>J
  else
    " open entry in a new horizontal window
    nnoremap <silent><buffer> <c-s> <c-w><cr>

    " preview entry under the cursor
    nnoremap <silent><buffer> p :call qf#preview#PreviewFileUnderCursor()<cr>
  endif

  " open entry in a new tab.
  nnoremap <silent><buffer> <c-t> <c-w><cr><c-w>T

  " open entry and come back
  nnoremap <silent><buffer> t <cr><c-w>p

  " open entry and close the location/quickfix window.
  if b:qf_isLoc == 1
    nnoremap <silent><buffer> T <cr>:lclose<cr>
  else
    nnoremap <silent><buffer> T <cr>:cclose<cr>
  endif
endif
