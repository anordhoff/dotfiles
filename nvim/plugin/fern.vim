" disable netrw
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
" let g:loaded_netrwSettings = 1
" let g:loaded_netrwFileHandlers = 1

" TODO: use CTRL-^ to immediately return to original buffer
"       use p to open a preview window of currently hovered file

" let g:fern#default_hidden = 1
" let g:fern#disable_drawer_smart_quit = 1
" let g:fern#keepalt_on_edit = 1
" let g:fern#keepjumps_on_edit = 1
" let g:fern#hide_cursor = 1 " TODO: doesn't work
"
" function! s:init_fern() abort
"   nmap <buffer> r <Plug>(fern-action-trash)
"   nmap <buffer> d <Plug>(fern-action-diff)
"   nmap <buffer> - <Plug>(fern-action-leave)
"   nmap <buffer> o <Plug>(fern-action-mark)
"   nmap <buffer> l <Plug>(fern-action-enter)
"   nmap <buffer> h <Plug>(fern-action-leave)
"   " nmap <buffer> l <Plug>(fern-action-expand)
"   " nmap <buffer> h <Plug>(fern-action-collapse)
"   " nmap <buffer> p :pedit<CR>
" endfunction
"
" augroup fern
"   autocmd!
"   autocmd FileType fern setlocal nonumber norelativenumber
"   autocmd FileType fern call s:init_fern()
" augroup END
"
" nnoremap <silent> - :Fern %:h<CR>
" nnoremap <silent> _ :Fern .<CR>
" nnoremap <silent> <leader>n :Fern . -reveal=% -drawer -toggle<CR>
