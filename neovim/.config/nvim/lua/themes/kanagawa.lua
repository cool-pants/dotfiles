return {
	name = "kanagawa",
	style = { "lotus", "dragon", "wave" },
	transparent = false,
	activate = function(style, transparency)
		require("kanagawa").setup({
			theme = style,
			transparency = transparency,
		})
		vim.cmd("colorscheme kanagawa" .. "-" .. style)
	end,
}
