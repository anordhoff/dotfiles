local treesitter = require('nvim-treesitter')

treesitter.setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}

local parsers = {
  'bash',
  'go',
  'json',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'vim',
  'yaml',
}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter_config', { clear = true }),
  pattern = parsers,
  callback = function()
    -- enable treesitter folding
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})
