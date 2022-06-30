local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

-- get home dir for use in local filepaths
local home_dir = os.getenv('HOME')

-- add a border to floating windows
-- TODO: enable borders on pmenu / :LspInfo
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or 'single'
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

-- customize how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = false,
  },
})

-- highlight line numbers when there are diagnostics to display
vim.fn.sign_define('DiagnosticSignError', { numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { numhl = 'DiagnosticSignHint' })

-- diagnostic keymaps
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist)

-- lsp settings
local on_attach = function(_, bufnr)
  -- enable completion (NOTE: onminfunc_sync.lua func for synchronous omnifunc)
  require('anordhoff.omnifunc_sync')
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.omnifunc_sync')

  -- keymaps
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>F', vim.lsp.buf.formatting, opts)
end

-- use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'bashls', 'cssls', 'dockerls', 'html', 'jsonls', 'pylsp', 'terraformls', 'tsserver', 'vimls' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach
  }
end


-------------------- gopls --------------------

-- setup configuration
lspconfig.gopls.setup {
  on_attach = on_attach,
  cmd = { 'gopls', 'serve' },
  filetypes = { 'go', 'gomod' },
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true
    }
  }
}

-- run the goimports command
local function goimports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { 'source.organizeImports' }}
  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, 'utf-16')
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

-- autoformat code when writing the buffer
local gopls_group = vim.api.nvim_create_augroup('gopls', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.formatting()
    goimports(1000)
  end,
  group = gopls_group,
  pattern = '*.go'
})


-------------------- sumneko_lua --------------------

-- path to binary
local path_to_binary = home_dir .. '/lua-language-server/bin/lua-language-server'

-- setup lua path
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- setup configuration
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = { path_to_binary },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim', 'use' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}


-------------------- yamlls --------------------

-- path to schemas
local cloudformation = 'https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json'

-- schema patterns
local patterns = {
  cloudformation = {
    '**/{cloudformation,cfn,aws}/**/*.{yml,yaml}',
    '**/{cfn,cloudformation,template}.{yml,yaml}'
  },
  kubernetes = {
    '**/{kubernetes,kube,k8s}/**/*.{yml,yaml}',
  }
}

-- read work specific schema patterns from jobfiles. Each schema should have a
-- newline separated list of glob patterns in its own file, where the name of
-- the file matches the name of the schema (.txt). Patterns are appended to the
-- nested table of the same under the 'patterns' table
local path_to_schemas = home_dir .. '/jobfiles/nvim/schemas/'
for schema, _ in pairs(patterns) do
  local file = io.open(path_to_schemas .. schema .. '.txt', 'r')
  if file ~= nil then
    while true do
      local line = file:read()
      if line == nil then
        break
      end
      table.insert(patterns[schema], line)
    end
    io.close(file)
  end
end

-- setup configuration
lspconfig.yamlls.setup {
  on_attach = on_attach,
  settings = {
    yaml = {
      format = { enable = true, singleQuote = true },
      validate = true,
      hover = true,
      completion = true,
      schemas = {
        [cloudformation] = patterns['cloudformation'],
        ['kubernetes'] = patterns['kubernetes']
      },
      customTags = {
        -- cloudformation custom tags
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
