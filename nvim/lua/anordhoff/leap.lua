local leap = require('leap')

leap.setup {
  case_insensitive = true,
  labels = {'n', 't', 'e', 's', 'i', 'r', 'o', 'a', 'h', 'd', 'u', 'f', 'y', 'w'},
  safe_labels = {},
}

vim.keymap.set('n', 'x', '<Plug>(leap-forward)')
vim.keymap.set('n', 'X', '<Plug>(leap-backward)')
vim.keymap.set('x', 'x', '<Plug>(leap-forward)')
vim.keymap.set('x', 'X', '<Plug>(leap-backward)')
vim.keymap.set('o', 'x', '<Plug>(leap-forward)')
vim.keymap.set('o', 'X', '<Plug>(leap-backward)')
vim.keymap.set('n', '<leader>x', '<Plug>(leap-cross-window)')
