-- TODO: use synchronous omnifunc when merged:
--   https://github.com/neovim/neovim/issues/12390
--   https://github.com/neovim/neovim/pull/16225

-- synchronous omnifunc that supports completeopt=longest
local omnifunc_cache
function _G.omnifunc_sync(findstart, base)
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  if findstart == 1 then
    -- Cache state of cursor line and position due to the fact that it will
    -- change at the second call to this function (with `findstart = 0`). See:
    -- https://github.com/vim/vim/issues/8510.
    -- This is needed because request to LSP server is made on second call.
    -- If not done, server's completion mechanics will operate on different
    -- document and position.
    omnifunc_cache = {pos = pos, line = line}

    -- On first call return column of completion start
    local line_to_cursor = line:sub(1, pos[2])
    return vim.fn.match(line_to_cursor, '\\k*$')
  end

  -- Restore cursor line and position to the state of first call
  vim.api.nvim_set_current_line(omnifunc_cache.line)
  vim.api.nvim_win_set_cursor(0, omnifunc_cache.pos)

  -- Make request
  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_position_params()
  local result = vim.lsp.buf_request_sync(bufnr, 'textDocument/completion', params, 2000)
  if not result then return {} end

  -- Transform request answer to list of completion matches
  local items = {}
  for _, item in pairs(result) do
    if not item.err then
      local matches = vim.lsp.util.text_document_completion_list_to_complete_items(item.result, base)
      vim.list_extend(items, matches)
    end
  end

  -- Restore back cursor line and position to the state of this call's start
  -- (avoids outcomes of Vim's internal line postprocessing)
  vim.api.nvim_set_current_line(line)
  vim.api.nvim_win_set_cursor(0, pos)

  return items
end
