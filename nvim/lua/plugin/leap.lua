-- TODO: https://github.com/ggandor/leap.nvim/issues/243
--       https://github.com/ggandor/leap.nvim/issues/272
--       https://github.com/ggandor/leap.nvim/commit/1abca0d146feceeb73679a62271cdedd6a28a8ee

local leap = require('leap')

leap.opts.labels = {'n', 't', 'e', 's', 'i', 'r', 'o', 'a', 'h', 'd', 'u', 'f', 'y', 'w', 'l', 'p', 'm', 'g', '-', 'c', ',', 'x', '\'', 'z', 'k', 'v'}
leap.opts.safe_labels = {'n', 't', 'u', 'f'}

vim.keymap.set({'n', 'x', 'o'}, 'x', '<Plug>(leap)')
vim.keymap.set('n',             'X', '<Plug>(leap-from-window)')
