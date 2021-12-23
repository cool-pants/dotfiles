local fn = vim.fn

-- Automatically install packer [ black magic ]
local install_math = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
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
  use "windwp/nvim-autopairs"   -- Autopairs, integrates with cmp and treesitter
  use "numToStr/Comment.nvim"   -- Easily comment stuff

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
