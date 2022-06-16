-- use a protected call so it doesn't error out on first use
local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

-- automatically run :PackerCompile when packer.lua is updated
local packer_group = vim.api.nvim_create_augroup('packer', { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = 'PackerCompile',
  group = packer_group,
  pattern = 'packer.lua'
})

-- load plugins
return packer.startup(function()
  use {
    'dstein64/vim-startuptime',
    'justinmk/vim-dirvish',
    'ludovicchabant/vim-gutentags',
    'svermeulen/vim-subversive',
    'tpope/vim-obsession',
    'tpope/vim-repeat',
    'tpope/vim-rsi',
    'tpope/vim-sleuth',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
    'wbthomason/packer.nvim',

    -- fugitive / rhubarb
    {
      {
	'tpope/vim-fugitive',
	-- opt = true,
	-- cmd = {
	--   "G", "Git", "Gedit", "Gsplit", "Gdiffsplit", "Gvdiffsplit",
	--   "Gread", "Gwrite", "Ggrep", "Glgrep",
	--   "GMove", "GDelete", "GRemove", "GBrowse"
	-- },
      },
      {
	'tpope/vim-rhubarb',
	requires = { 'tpope/vim-fugitive' },
      },
    },

    -- comment --
    {
      'numToStr/Comment.nvim',
      config = 'require("anordhoff.comment")',
    },

    -- gitsigns --
    {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = 'require("anordhoff.gitsigns")',
    },

    {
      'lewis6991/impatient.nvim',
    },

    -- leap --
    {
      'ggandor/leap.nvim',
      requires = { 'tpope/vim-repeat' },
      config = 'require("anordhoff.leap")',
    },

    -- lspconfig --
    {
      'neovim/nvim-lspconfig',
      config = 'require("anordhoff.lspconfig")',
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

    -- treesitter --
    {
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = 'require("anordhoff.treesitter")',
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = { 'nvim-treesitter/nvim-treesitter' },
      },
    },
  }
end)
