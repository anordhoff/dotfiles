" don't run jobs in a tmux split
let g:dispatch_no_tmux_make = 1
let g:dispatch_no_tmux_start = 1

" run dispatch with a 'match everything' compiler
" TODO: update z? to show focused dispatch
nnoremap z<cr>    :Run<cr>
nnoremap z<space> :Run<space>
nnoremap z!       :Run!
nnoremap z?       :echo ':Dispatch -compiler=stdout'<cr>

command! -nargs=? -bang Run call s:run(<bang>0, <q-args>)
function s:run(bang, args)
  if a:bang
    let l:bang = '!'
  else
    let l:bang = ''
  endif
  if len(a:args)
    let l:args = join(map(split(a:args, '\ze[<%#]'), 'expand(v:val)'), '')
  else
    let l:args = ''
  endif
  execute 'Dispatch' . l:bang ' -compiler=stdout ' . l:args
endfunction

" warn when 'x' mapping is used for filetype that does not support it
nnoremap x<cr> :echohl ErrorMsg \| echo 'E492: x<cr\> not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>
nnoremap x<space> :echohl ErrorMsg \| echo 'E492: x<space\> not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>
nnoremap x! :echohl ErrorMsg \| echo 'E492: x! not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>
nnoremap x? :echohl ErrorMsg \| echo 'E492: x? not mapped for
  \ filetype: ' .. &filetype \| echohl None<cr>


" --------------------------------------
" golang
" --------------------------------------

" build a go package
autocmd Filetype go let b:dispatch = 'go build ./%:h'

" test a go package
autocmd Filetype go nnoremap x<cr>    :Dispatch go test -fullpath ./%:h<cr>
autocmd Filetype go nnoremap x<space> :Dispatch go test -fullpath ./%:h -run<space>
autocmd Filetype go nnoremap x!       :Dispatch! go test -fullpath ./%:h
autocmd Filetype go nnoremap x?       :echo ':Dispatch go test -fullpath ./%:h'<cr>
