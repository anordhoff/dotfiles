" revert the 'b' object back to vim default; disable 'q' object
autocmd User targets#mappings#user call targets#mappings#extend({
  \ 'b': {'pair': [{'o':'(', 'c':')'}]},
  \ 'q': {}
  \ })
