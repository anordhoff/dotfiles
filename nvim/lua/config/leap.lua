local leap = require('leap')

leap.opts.labels = {'n', 't', 'e', 's', 'i', 'r', 'o', 'a', 'h', 'd', 'u', 'f', 'y', 'w', 'l', 'p', 'm', 'g', ',', 'c', '.', 'x', '/', 'z', 'k', 'v'}
leap.opts.safe_labels = {}

local function bidirectional()
  leap.leap { target_windows = { vim.fn.win_getid() } }
end

local opts = { silent = true }
vim.keymap.set({'n', 'x', 'o'}, 's', bidirectional, opts)
vim.keymap.set('n', 'S', '<plug>(leap-from-window)', opts)
