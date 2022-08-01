setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal listchars=tab:\ \ ,lead:-,trail:-

nnoremap <leader>gr :!go run<space>
nnoremap <leader>gb :!go build<space>
nnoremap <leader>gt :!go test<space>
nnoremap <leader>gi :!go install<space>

" edit the current file's test file, or a test file's normal file
nnoremap <silent> <leader>ee :call AlternateFile('edit')<CR>
nnoremap <silent> <leader>es :call AlternateFile('split')<CR>
nnoremap <silent> <leader>ev :call AlternateFile('vsplit')<CR>
nnoremap <silent> <leader>et :call AlternateFile('tabnew')<CR>
function AlternateFile(n)
	if stridx(expand("%:t"), '_test') == -1
		exec a:n ' ' . expand("%:r") . '_test.go'
	else
		exec a:n ' ' . expand("%:h") . '/' . substitute(expand("%:t"), '_test', '', '')
	endif
endfunction
