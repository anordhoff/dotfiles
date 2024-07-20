local leap = require('leap')

-- TODO: leap doesn't work if the file only has one line

leap.opts.labels = {'n', 't', 'e', 's', 'i', 'r', 'o', 'a', 'h', 'd', 'u', 'f', 'y', 'w', 'l', 'p', 'm', 'g', ',', 'c', '.', 'x', '/', 'z', 'k', 'v'}
leap.opts.safe_labels = {}

local function bidirectional()
  leap.leap { target_windows = { vim.fn.win_getid() } }
end

local opts = { silent = true }
vim.keymap.set({'n', 'x', 'o'}, 's', bidirectional, opts)
vim.keymap.set('n', 'S', '<plug>(leap-from-window)', opts)

-- local leap_group = vim.api.nvim_create_augroup('leap', { clear = true })
-- vim.api.nvim_create_autocmd('LeapEnter', {
--   group = leap_group,
--   callback = function()
--     vim.wo.conceallevel = 2
--   end,
--   pattern = 'LeapEnter'
-- })

-- function custom_leap_func()
--   leap.leap {
--     is_custom_leap_func = true,
--       -- ...
--   }
-- end

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'LeapEnter',
--   callback = function (event)
--     if leap.state.args.is_custom_leap_func then
--       -- Implement some special logic here, that will only apply to
--       -- custom_leap_func(), and restore the state (if needed) in an
--       -- analogous `LeapLeave` autocommand.
--     end
--   end
-- })

-- do
--   local saved_conceallevel
--   vim.api.nvim_create_autocmd('User', {
--     pattern = 'LeapEnter',
--     callback = function ()
--       saved_conceallevel = vim.wo.conceallevel
--       vim.wo.conceallevel = 2
--     end,
--   })
--   vim.api.nvim_create_autocmd('User', {
--     pattern = 'LeapLeave',
--     callback = function () vim.wo.conceallevel = saved_conceallevel end,
--   })
-- end
