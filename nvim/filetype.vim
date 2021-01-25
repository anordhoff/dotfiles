" my filetype file
if exists("did_load_filetypes")
    finish
endif

" set filetype for template and backup files (need to further generalize)
let s:l = ['*.tpl', '*.template', '*.bak', '*.backup']
execute "autocmd BufNewFile,BufRead " . join(s:l, ',') . " call s:SetFileType()"

function s:SetFileType()
    let s:s = split(expand('%:t'), '\.')
    if len(s:s) > 1
        let s:d = {'js':  'javascript',
                 \ 'jsx': 'javascriptreact',
                 \ 'ts':  'typescript',
                 \ 'tsx': 'typescriptreact',
                 \ 'tf':  'terraform'}
        let &ft=has_key(s:d, s:s[1]) ? s:d[s:s[1]] : s:s[1]
    endif
endfunction
