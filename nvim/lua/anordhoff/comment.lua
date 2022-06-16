require('Comment').setup()

vim.keymap.set('n', 'gy', '<cmd>set operatorfunc=v:lua.___gy<CR>g@')
vim.keymap.set('n', 'gyc', '<cmd>lua ___gyc()<CR>')
vim.keymap.set('x', 'gy', '<esc><cmd>lua ___gy(vim.fn.visualmode())<CR>')


-- https://github.com/numToStr/Comment.nvim/pull/73#issuecomment-974678667
local utils = require("Comment.utils")
local api = require("Comment.api")

function _G.___gy(vmode)
  local range = utils.get_region(vmode)
  local lines = utils.get_lines(range)

  -- Copying the block
  local srow = range.erow
  vim.api.nvim_buf_set_lines(0, srow, srow, false, lines)

  -- Doing the comment
  api.comment_linewise_op(vmode)

  -- Move the cursor
  local erow = srow + 1
  local line = utils.get_lines({ srow = srow, erow = erow })
  local _, col = utils.grab_indent(line[1])
  vim.api.nvim_win_set_cursor(0, { erow, col })
end

-- TODO: dot repeat doesn't work for gyc
function _G.___gyc()
  api.call(___gy())
end
