local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local windows = require('lspconfig.ui.windows')

-- border style
local border = 'single'

-- add a border to floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- add a border to :LspInfo window
windows.default_options.border = border

-- customize how diagnostics are displayed
vim.diagnostic.config({
  float = {
    source = true,
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = false,
})

-- highlight line numbers when there are diagnostics to display
vim.fn.sign_define('DiagnosticSignError', { numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { numhl = 'DiagnosticSignHint' })

-- TODO: fill out code_action_utils.lua
-- show a sign when a code action is available
-- vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
--   group = vim.api.nvim_create_augroup('codeactions', { clear = true }),
--   callback = function()
--     require('config.code_action_utils').code_action_listener()
--   end,
--   pattern = '*'
-- })

-- print client information
vim.api.nvim_create_user_command(
  'LspInspect',
  function()
    print(vim.inspect(vim.lsp.buf_get_clients()))
  end,
  {}
)

-- diagnostic keymaps
local opts = { silent = true }
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, opts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)

-- lsp settings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lspconfig', { clear = true }),
  callback = function(ev)
    -- enable completion (onminfunc_sync.lua func for synchronous omnifunc)
    -- https://github.com/neovim/neovim/pull/17218
    require('config.omnifunc_sync')
    vim.bo[ev.buf].omnifunc = 'v:lua.omnifunc_sync'

    -- keymaps
    local bufopts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('i', '<c-k>', function()
      if vim.fn.col('.') > vim.fn.strlen(vim.fn.getline('.')) then
        return vim.lsp.buf.signature_help() else
        return vim.cmd.normal('D') and vim.fn.cursor(vim.fn.line('.'), vim.fn.col('.') + 1) end
    end, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>F', function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end,
})

-- use a loop to call 'setup' on multiple servers
local servers = { 'bashls', 'cssls', 'eslint', 'html', 'jsonls', 'pylsp', 'terraformls', 'tsserver', 'vimls' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {}
end


----------------------------------------
-- gopls
----------------------------------------

-- setup configuration
lspconfig.gopls.setup {
  cmd = { 'gopls', '-remote=auto' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      analyses = {
        fieldalignment = false,
        nilness = true,
        shadow = true,
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

-- TODO: hide "no code actions available" when no changes are made to imports
-- TODO: async code_actions can cause goimports to run after saving the file
--       (https://github.com/neovim/neovim/issues/24168)
-- TODO: running format AFTER async code_actions blows up imports
-- NOTE: formatting extra tabs will delete the tab and three extra characters
--       set sts=0 fixes this

-- format code and organize imports when writing the buffer
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('gopls', { clear = true }),
  callback = function()
    vim.lsp.buf.format{ async = false }
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end,
  pattern = '*.go',
})


----------------------------------------
-- lua_ls
----------------------------------------

-- setup configuration
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'use' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}


----------------------------------------
-- yamlls
----------------------------------------

-- get home dir for use in local filepaths
local home_dir = os.getenv('HOME') .. '/'

-- path to schemas
local cloudformation = 'https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json'

-- schema patterns
local patterns = {
  cloudformation = {
    '**/{cloudformation,cfn,aws}/**/*.{yml,yaml}',
    '**/{cfn,cloudformation,template}.{yml,yaml}',
  },
  kubernetes = {
    '**/{kubernetes,kube,k8s}/**/*.{yml,yaml}',
  },
}

-- read work specific schema patterns from jobfiles. Each schema should have a
-- newline separated list of glob patterns in its own file, where the name of
-- the file matches the name of the schema (.txt). Patterns are appended to the
-- nested table of the same under the 'patterns' table
local path_to_schemas = home_dir .. 'jobfiles/nvim/schemas/'
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
  settings = {
    yaml = {
      format = { enable = true, singleQuote = true },
      validate = true,
      hover = true,
      completion = true,
      schemas = {
        [cloudformation] = patterns['cloudformation'],
        ['kubernetes'] = patterns['kubernetes'],
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
        '!Sub sequence',
      },
    },
  },
}
