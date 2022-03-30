local lspconfig = require('lspconfig')

-- Add a border to floating windows
-- TODO: enable borders on completion/omnifunc
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Customize how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = 'if_many',
  },
})

-- Only highlight line numbers when there are diagnostics
vim.fn.sign_define('DiagnosticSignError', { numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { numhl = 'DiagnosticSignHint' })

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'bashls', 'cssls', 'dockerls', 'html', 'jsonls', 'pylsp', 'terraformls', 'tsserver', 'vimls' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end


-------------------- gopls --------------------

lspconfig.gopls.setup {
  on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  cmd = { 'gopls', 'serve' },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true
    }
  }
}

function goimports(timeout_ms)
  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

vim.cmd([[
  augroup gopls
    autocmd!
    autocmd BufWritePre *.go lua goimports(1000)
  augroup end
]])


-------------------- sumneko_lua --------------------

-- path to binary
local home_dir = os.getenv('HOME')
local binary_path = '/lua-language-server/bin/lua-language-server'

-- setup lua path
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- setup configuration
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  cmd = { home_dir .. binary_path },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


-------------------- yamlls --------------------

-- path to schema
local schema_path = '/dotfiles/nvim/lua/plugin/lspconfig/cfn-lint.json'

-- setup configuration
lspconfig.yamlls.setup {
  on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  settings = {
    yaml = {
      schemas = {
        [home_dir .. schema_path] = '**/{cloudformation,cfn,aws}/**/*.yaml'
      },
      customTags = {
        '!And mapping',
        '!And scalar',
        '!And sequence',
        '!Base64 mapping',
        '!Base64 scalar',
        '!Base64 sequence',
        '!Cidr mapping',
        '!Cidr scalar',
        '!Cidr sequence',
        '!Equals mapping',
        '!Equals scalar',
        '!Equals sequence',
        '!FindInMap mappping',
        '!FindInMap scalar',
        '!FindInMap sequence',
        '!GetAtt mapping',
        '!GetAtt scalar',
        '!GetAtt sequence',
        '!GetAZs mapping',
        '!GetAZs scalar',
        '!GetAZs sequence',
        '!If mapping',
        '!If scalar',
        '!If sequence',
        '!ImportValue mapping',
        '!ImportValue scalar',
        '!ImportValue sequence',
        '!Join mapping',
        '!Join scalar',
        '!Join sequence',
        '!Not mapping',
        '!Not scalar',
        '!Not sequence',
        '!Or mapping',
        '!Or scalar',
        '!Or sequence',
        '!Ref mapping',
        '!Ref scalar',
        '!Ref sequence',
        '!Select mapping',
        '!Select scalar',
        '!Select sequence',
        '!Split mapping',
        '!Split scalar',
        '!Split sequence',
        '!Sub mapping',
        '!Sub scalar',
        '!Sub sequence'
      }
    }
  }
}
