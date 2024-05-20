return {
	name = "tokyonight",
	style = { "storm", "moon", "night", "day" },
	transparent = false,
	activate = function(style, transparent)
		require("tokyonight").setup({
			style = style,
			transparent = transparent,
		})

		vim.cmd.colorscheme("tokyonight")
	end,
}
