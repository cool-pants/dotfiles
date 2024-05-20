return {
	name = "oxocarbon",
	style = { "dark", "light" },
	transparent = false,
	activate = function(style, _)
		vim.o.background = style
		vim.cmd("colorscheme oxocarbon")
	end,
}
