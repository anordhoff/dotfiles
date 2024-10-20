local lint = require('lint')
local golangci_lint = require('lint.linters.golangcilint')

lint.linters_by_ft = {
  go = { 'golangcilint' },
}

golangci_lint.args = {
  'run',
  '--out-format',
  'json',
  '--max-issues-per-linter',
  '0',
  '--max-same-issues',
  '0',
}

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    lint.try_lint()
  end,
  pattern = '*.go',
})
