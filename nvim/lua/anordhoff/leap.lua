local leap = require('leap')

leap.setup {
  labels = {'n', 't', 'e', 's', 'i', 'r', 'o', 'a', 'h', 'd', 'u', 'f', 'y', 'w'},
  safe_labels = {},
}

function leap_bidirectional()
  leap.leap { ['target-windows'] = { vim.api.nvim_get_current_win() } }
end

-- TODO: leap doesn't respect `<leader>` mappings
local opts = { silent = true }
vim.keymap.set('n', 'x', leap_bidirectional, opts)
vim.keymap.set('x', 'x', leap_bidirectional, opts)
vim.keymap.set('o', 'x', leap_bidirectional, opts)
vim.keymap.set('n', 'X', '<Plug>(leap-cross-window)', opts)
