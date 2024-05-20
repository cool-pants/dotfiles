return {
	name = "gruvbox",
	style = { "dark", "light" },
	transparent = false,
	activate = function(style, _)
		vim.o.background = style
		vim.cmd.colorscheme("gruvbox")
	end,
}
