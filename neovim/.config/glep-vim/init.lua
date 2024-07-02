vim.g.mapleader = ' '

_G.my_languages_ft = {
	"cpp",
	"rust",
	"go",
	"lua",
	"sh",
	"python",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"json",
}

require("core")
require("internal.event")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
