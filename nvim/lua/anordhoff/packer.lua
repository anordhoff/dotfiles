-- TODO: what does this do
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- automatically run :PackerCompile when packer.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
  use {
    -- vim --
    'AndrewRadev/splitjoin.vim',
    'ludovicchabant/vim-gutentags',
    'tweekmonster/startuptime.vim',
    -- {
    --   'fatih/vim-go',
    --   run = ':GoUpdateBinaries',
    --   ft = { 'go', 'go.mod', 'go.sum' }
    -- },


    -- tpope --
    -- TODO: vim fugitive, lazyload?
    {
      'tpope/vim-commentary',
      'tpope/vim-fugitive',
      'tpope/vim-obsession',
      'tpope/vim-repeat',
      'tpope/vim-rhubarb',
      'tpope/vim-sleuth',
      'tpope/vim-surround',
      'tpope/vim-unimpaired',
      'tpope/vim-vinegar',
    },


    -- gitsigns --
    {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = 'require("anordhoff.gitsigns")',
    },

    -- lspconfig --
    {
      'neovim/nvim-lspconfig',
      config = 'require("anordhoff.lspconfig.lspconfig")',
    },


    -- treesitter --
    {
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = 'require("anordhoff.treesitter")',
      },
      {
        'nvim-treesitter/playground',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = { 'nvim-treesitter/nvim-treesitter' },
      },
    },


    -- telescope --
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
      module = 'telescope',
      setup = 'require("anordhoff.telescope.setup")',
      config = 'require("anordhoff.telescope.config")',
    },


    -- packer --
    'wbthomason/packer.nvim',
  }
end)
