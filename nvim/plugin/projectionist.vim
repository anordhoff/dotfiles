let g:projectionist_heuristics = {
  \ '*': {
  \   'Dockerfile': {
  \     'type': 'dockerfile',
  \   },
  \   'Makefile': {
  \     'type': 'makefile',
  \   },
  \   'readme.md': {
  \     'type': 'readme',
  \   },
  \ },
  \ '*.go': {
  \   '*.go': {
  \     'alternate': '{}_test.go',
  \     'console': 'dlv debug {}.go',
  \     'dispatch': 'go build',
  \     'type': 'source'
  \   },
  \   '*_test.go': {
  \     'alternate': '{}.go',
  \     'console': 'dlv test {}.go {}_test.go',
  \     'dispatch': 'go test',
  \     'type': 'test'
  \   }
  \ }}

source ~/jobfiles/nvim/plugin/projectionist.vim
let g:projectionist_heuristics['*'][g:projectionist_cicd_key] = g:projectionist_cicd_value
