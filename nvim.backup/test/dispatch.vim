let g:dispatch_no_tmux_make = 1
let g:dispatch_no_tmux_start = 1

" TODO: make :Start open in a smaller window
" let g:dispatch_quickfix_height = 10

nnoremap d<cr>    :Dispatch<cr>
nnoremap d<space> :Dispatch<space>
nnoremap d!       :Dispatch!

" prevent :Start<space> from exiting automatically on a successful command
let g:nremap = {"'": ""}
nnoremap '<cr>    :Start<cr>10<c-w>_
nnoremap '<space> :Start -wait=always<space>
nnoremap '!       :Start!
nnoremap '?       :echo ":Start" dispatch#start_focus(v:count > 1 ? 0 :
                    \ v:count ? line(".") : -1)<CR>

" build a go package
autocmd Filetype go let b:dispatch = 'go build ./%:h'

" test a go package
autocmd Filetype go nnoremap d<cr>    :Dispatch go test ./%:h<cr>
autocmd Filetype go nnoremap d<space> :Dispatch go test ./%:h<space>
autocmd Filetype go nnoremap d!       :Dispatch! go test ./%:h





" run unit tests for a package
" autocmd Filetype go let b:dispatch = 'go test ./%:h'

" default dispatch command builds the current file
" autocmd Filetype go let b:dispatch = 'go build %'

" run unit test for all files in a package
" TODO: -fullpath flag in go test; planned for go 1.21 (https://github.com/golang/go/issues/37708)
" autocmd Filetype go nnoremap d<cr> :Dispatch go test ./%:h<cr>

" run unit tests for a single file
" NOTE: breaks if * depends on a function from another file in the package
" autocmd Filetype go nnoremap dr :Dispatch go test ./% ./%:r_test.go<cr>

" TODO: make this also work if in a test file
" command! -nargs=1 Test call s:AlternateFile(n)
" function s:AlternateFile(n)
"   " if stridx(expand("%:t"), '_test') == -1
"   "   " exec a:n ' ' . expand("%:r") . '_test.go'
"   "   return ' ' . expand("%:r") . '_test.go'
"   " else
"   "   " exec a:n ' ' . expand("%:h") . '/' . substitute(expand("%:t"), '_test', '', '')
"   "   return ' ' . expand("%:h") . '/' . substitute(expand("%:t"), '_test', '', '')
"   " endif
"   exec ':Dispatch'
" endfunction
