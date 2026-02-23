-- organize imports on save
-- NOTE: changes to imports are not saved (https://github.com/neovim/neovim/issues/24168)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup('lspconfig_golang_config', { clear = true }),
  callback = function()
    vim.lsp.buf.format { async = true }
    vim.lsp.buf.code_action { context = { diagnostics = {}, only = { 'source.organizeImports' } }, apply = true }
  end,
  pattern = "*.go",
})

return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  settings = {
    gopls = {
      analyses = {
        fieldalignment = false,
        nilness = true,
        shadow = false,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        unusedvariable = true,
      },
      linksInHover = false,
      staticcheck = true,
    },
  },
}
