packadd({
	"neovim/nvim-lspconfig",
	ft = _G.my_program_ft,
	dependencies = {

		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local i = "■"
		vim.diagnostic.config({ signs = { text = { i, i, i, i } } })
		require("modules.lsp.backend")
		require("modules.lsp.frontend")
	end,
})

packadd({
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enable = false,
				hide_keyword = true,
				folder_level = 0,
			},
			lightbulb = {
				sign = false,
			},
			outline = {
				layout = "float",
			},
		})
	end,
})

packadd({
	"nvimdev/epo.nvim",
	event = "LspAttach",
	config = function()
		require("epo").setup()
	end,
})
