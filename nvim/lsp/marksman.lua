vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('marksman_config', { clear = true }),
  pattern = { "*.md", "*.mdx" },
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_markers = { ".marksman.toml", ".git" },
}
