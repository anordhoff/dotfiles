local leap = require('leap')

leap.opts.labels = {'n', 't', 'e', 's', 'i', 'r', 'o', 'a', 'h', 'd', 'u', 'f', 'y', 'w', 'l', 'p', 'm', 'g', '-', 'c', ',', 'x', '\'', 'z', 'k', 'v'}
leap.opts.safe_labels = {'n', 't', 'u', 'f'}

vim.keymap.set({'n', 'x', 'o'}, 'x', '<Plug>(leap)')
vim.keymap.set('n',             'X', '<Plug>(leap-from-window)')
