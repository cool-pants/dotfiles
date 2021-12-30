local fn = vim.fn

-- Automatically install packer [ black magic ]
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer ...close and reopen Neovim"
  vim.cmd [[packadd packer.nvim]]
end

--Autocommand that reloads neovim upon save of plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so that we don't error out on first use :)
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install the Plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"  -- Have Packer manager itself [ big brain ]
  use "nvim-lua/popup.nvim"     -- Popup API
  use "nvim-lua/plenary.nvim"   -- Useful lua functions
  use "windwp/nvim-autopairs"   -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim"   -- Commenting made easier
  use "kyazdani42/nvim-web-devicons"
  -- nvim-tree has problems running on windows after this commit Issue#845
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "b853e1083c67a79b4eb046a112a8e12b35e9cd19",
  }
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"

  -- ColorScheme setup
  use "folke/tokyonight.nvim"
  use "lunarvim/darkplus.nvim"
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- TreeSitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use "JoosepAlviste/nvim-ts-context-commentstring"
  -- Git
  use "lewis6991/gitsigns.nvim"

  -- LuaLine adds a vscode like line
  use "nvim-lualine/lualine.nvim"

  -- Adds good key-press support[a must have, makes you not have to press leader combinations Super fast]
  use "folke/which-key.nvim"

  -- Loads from cache coz, you guessed it, I am impatient
  use "lewis6991/impatient.nvim"

  -- Sessions, very usefull
  use({
    "folke/persistence.nvim",
    event = "BufReadPre", -- only start session saving when actual file is open not for just 'nvim'
    module = "persistence",
  })

  -- Indent line to understand which indent for what :)
  use "lukas-reineke/indent-blankline.nvim"

  -- Alpha for a good dashboard
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
