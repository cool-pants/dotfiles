local conf = require("modules.editor.config")

packadd({
	"numToStr/Comment.nvim",
	opts = {},
})

packadd({
	"stevearc/oil.nvim",
	config = conf.oil,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
})

packadd({
	"folke/flash.nvim",
	event = "VeryLazy",
})

packadd({
	"echasnovski/mini.nvim",
	config = conf.mini,
})

packadd({
	"folke/trouble.nvim",
	cmd = "Trouble",
})

packadd({
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	config = conf.telescope,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
})

packadd({
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	build = ":TSUpdate",
	config = conf.nvim_treesitter,
})

packadd({
	"nvim-treesitter/nvim-treesitter-context",
	event = "BufEnter",
	config = conf.nvim_treesitter_context,
})

packadd({
	"windwp/nvim-ts-autotag",
	event = "BufReadPre",
	config = conf.ts_autotag,
})

packadd({
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = conf.conform,
})

--@see https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/507
packadd({
	"nvim-treesitter/nvim-treesitter-textobjects",
	ft = { "c", "rust", "go", "lua" },
	config = function()
		vim.defer_fn(function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner" },
						},
					},
				},
			})
		end, 0)
	end,
})
