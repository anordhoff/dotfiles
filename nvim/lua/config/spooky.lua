local spooky = require('spooky')
local leap = require('leap')

local current_window_keymap = 'x'
local from_window_keymap = 'X'

-- create remote objects from targets.vim text objects
local targets_text_objects = {
  'ir', 'ar', 'iR', 'aR', 'iq', 'aq', 'iQ', 'aQ', 'ia', 'aa',
  'i,', 'i.', 'i;', 'i:', 'i+', 'i-', 'i=', 'i~', 'i_', 'i*', 'i#', 'i/', 'i|', 'i\\', 'i&', 'i$',
  'a,', 'a.', 'a;', 'a:', 'a+', 'a-', 'a=', 'a~', 'a_', 'a*', 'a#', 'a/', 'a|', 'a\\', 'a&', 'a$',
}

-- create remote objects from nvim-treesitter-textobjects text objects
local treesitter_text_objects = {
  'if', 'af', "ic", "ac", "iC", "aC", "iL", "aL",
}


-- restore cursor position (except after change operation)
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('spooky_config', { clear = true }),
  pattern = 'SpookyOperationDone',
  callback = function(event)
    if vim.v.operator ~= 'c' then
      event.data.restore_cursor()
    end
  end,
})

-- target the current window
local leap_current_window = function()
  leap.leap {
    opts = { safe_labels = {} },
    target_windows = { vim.api.nvim_get_current_win() },
  }
end

-- target non-current windows in the current tabpage
local leap_from_window = function()
  leap.leap {
    opts = { safe_labels = {} },
    target_windows = vim.tbl_filter(
      function(win)
        if win == vim.api.nvim_get_current_win() then
          return false
        end
        return vim.api.nvim_win_get_config(win).focusable
      end,
      vim.api.nvim_tabpage_list_wins(0)
    ),
  }
end

local text_objects = {
  spooky.default_text_objects,
  treesitter_text_objects,
  targets_text_objects,
}

for _, tobjs in ipairs(text_objects) do
  for _, tobj in ipairs(tobjs) do
    local current_window_mapping = tobj:sub(1,1) .. current_window_keymap .. tobj:sub(2)
    spooky.create_text_object(current_window_mapping, leap_current_window, spooky.selector(tobj))

    local from_window_mapping = tobj:sub(1,1) .. from_window_keymap .. tobj:sub(2)
    spooky.create_text_object(from_window_mapping, leap_from_window, spooky.selector(tobj))
  end
end
