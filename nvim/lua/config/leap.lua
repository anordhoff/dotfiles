local leap = require('leap')

leap.setup {
  labels = {'n', 't', 'e', 's', 'i', 'r', 'o', 'a', 'h', 'd', 'u', 'f', 'y', 'w', 'l', 'p', 'm', 'g', ',', 'c', '.', 'x', '/', 'z', 'k', 'v'},
  safe_labels = {},
}

function bidirectional()
  leap.leap { target_windows = { vim.fn.win_getid() } }
end

local opts = { silent = true }
vim.keymap.set('n', 'x', bidirectional, opts)
vim.keymap.set('x', 'x', bidirectional, opts)
vim.keymap.set('o', 'x', bidirectional, opts)
vim.keymap.set('n', 'X', '<plug>(leap-cross-window)', opts)
