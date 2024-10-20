" edit the current file's alternate file
nnoremap <silent><buffer> <leader>aa <cmd>call go#alternate_file('edit')<cr>
nnoremap <silent><buffer> <leader>as <cmd>call go#alternate_file('split')<cr>
nnoremap <silent><buffer> <leader>av <cmd>call go#alternate_file('vsplit')<cr>
nnoremap <silent><buffer> <leader>at <cmd>call go#alternate_file('tabnew')<cr>
