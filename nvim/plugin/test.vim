let test#strategy = "dispatch"
let test#go#runner = 'gotest'
let test#go#gotest#options = '-fullpath'
let g:test#runner_commands = ['GoTest', 'Delve']

" keymaps
nnoremap <silent> <leader>tt :TestNearest<cr>
nnoremap <silent> <leader>T  :TestFile<cr>
nnoremap <silent> <leader>tp :TestSuite<cr>
nnoremap <silent> <leader>tc :TestClass<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tg :TestVisit<cr>

augroup test_config
  autocmd!
  autocmd Filetype go nnoremap <leader>t<space> :GoTest ./%:h/... -run<space>
  autocmd Filetype go nnoremap <silent> z<cr> :call DebugNearest('delve')<cr>
  autocmd Filetype go nnoremap <silent> Z<cr> :call DebugFile('delve')<cr>
augroup END

" spawn a debugging terminal session
function! DebugFile(runner)
  let g:test#go#runner = a:runner
  TestFile -strategy=spawn
  unlet g:test#go#runner
endfunction

function! DebugNearest(runner)
  let g:test#go#runner = a:runner
  TestNearest -strategy=spawn
  unlet g:test#go#runner
endfunction
