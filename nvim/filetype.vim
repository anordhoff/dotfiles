" my filetype file
if exists("did_load_filetypes")
    finish
endif

" set filetype for template and backup files (need to further generalize)
augroup filetypetemplatebackup
    let s:s = split(expand('%:t'), '\.')
    if len(s:s) > 1
        let s:l = ['*.tpl', '*.template', '*.bak', '*.backup']
        let s:d = {'js':  'javascript',
                 \ 'jsx': 'javascriptreact',
                 \ 'ts':  'typescript',
                 \ 'tsx': 'typescriptreact',
                 \ 'tf':  'terraform'}
        autocmd!
        execute "autocmd BufNew,BufNewFile,BufRead " . join(s:l, ',') . " set filetype=" . (has_key(s:d, s:s[1]) ? s:d[s:s[1]] : s:s[1])
    endif
augroup END
