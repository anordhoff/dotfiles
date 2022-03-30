" let g:go_fmt_command = "goimports"
" let g:go_fmt_fail_silently = 1
" let g:go_def_mapping_enabled = 0
" let g:go_doc_keywordprg_enabled = 0

" " key mappings
" autocmd Filetype go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
" autocmd Filetype go nmap <leader>gr <plug>(go-run)
" autocmd Filetype go nmap <leader>gt <plug>(go-test)
" autocmd Filetype go nmap <leader>gc <plug>(go-coverage-toggle)
" autocmd Filetype go command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
" autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
" autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
" autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" " run :GoBuild or :GoTestCompile based on the go file
" function! s:build_go_files()
"   let l:file = expand('%')
"   if l:file =~# '^\f\+_test\.go$'
"     call go#test#Test(0, 1)
"   elseif l:file =~# '^\f\+\.go$'
"     call go#cmd#Build(0)
"   endif
" endfunction
