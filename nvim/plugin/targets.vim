" both growing and seeking will work on the largest available count if a too
" large count it given
let g:targets_gracious = 1

" revert the 'b' object back to vim default; disable 'q' object
autocmd User targets#mappings#user call targets#mappings#extend({
  \ 'b': {'pair': [{'o':'(', 'c':')'}]},
  \ 's': { 'separator': [{'d':','}, {'d':'.'}, {'d':';'}, {'d':':'}, {'d':'+'}, {'d':'-'},
  \                      {'d':'='}, {'d':'~'}, {'d':'_'}, {'d':'*'}, {'d':'#'}, {'d':'/'},
  \                      {'d':'\'}, {'d':'|'}, {'d':'&'}, {'d':'$'}] },
  \ })
