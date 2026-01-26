-- TODO(bug): lint.nvim is slow (30% of startup time) (should I lazyload?)
local lint = require('lint')
local linters = lint.linters

lint.linters_by_ft = {
  go = { 'golangcilint' },
}

linters.golangcilint.args = {
  'run',
  '--output.json.path=stdout',
  '--show-stats=false',
  '--issues-exit-code',
  '0',
  '--max-same-issues',
  '0',
  '--max-issues-per-linter',
  '0',
}

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('lint_config', { clear = true }),
  callback = function()
    lint.try_lint()
  end,
  pattern = '*.go',
})

return lint
