" don't run jobs in a tmux split
let g:dispatch_no_tmux_make = 1
let g:dispatch_no_tmux_start = 1

" run dispatch with a 'match everything' compiler
command -nargs=? -bang Run call plugin#dispatch#run(<bang>0, <q-args>)
command PrintStdoutFocus call plugin#dispatch#print_stdout_focus()
nnoremap z<cr>    <cmd>Run<cr>
nnoremap z<space> :Run<space>
nnoremap z!       :Run!
nnoremap z?       <cmd>PrintStdoutFocus<cr>

" warn when 'x' mapping is used for filetype that does not support it
nnoremap x<cr> <cmd>echohl ErrorMsg \| echo 'E492: x<cr\> not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>
nnoremap x<space> <cmd>echohl ErrorMsg \| echo 'E492: x<space\> not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>
nnoremap x! <cmd>echohl ErrorMsg \| echo 'E492: x! not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>
nnoremap xx <cmd>echohl ErrorMsg \| echo 'E492: xx not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>
nnoremap x? <cmd>echohl ErrorMsg \| echo 'E492: x? not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>


" --------------------------------------
" golang
" --------------------------------------

augroup dispatch_go
  autocmd!

  " build a go package
  autocmd Filetype go let b:dispatch = 'go build ./%:h'

  " test a go package
  autocmd Filetype go nnoremap x<cr>    <cmd>Dispatch go test -fullpath ./%:h<cr>
  autocmd Filetype go nnoremap x<space> :Dispatch go test -fullpath ./%:h -run<space>
  autocmd Filetype go nnoremap x!       :Dispatch! go test -fullpath ./%:h
  autocmd Filetype go nnoremap xx       <cmd>Dispatch go test -fullpath ./%:h -run <cword><cr>
  autocmd Filetype go nnoremap x?       <cmd>echo ':Dispatch go test -fullpath ./%:h'<cr>
augroup END
