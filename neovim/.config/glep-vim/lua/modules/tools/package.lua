local conf = require("modules.tools.config")

packadd({
	"tpope/vim-fugitive",
})

packadd({
	"lewis6991/gitsigns.nvim",
	config = conf.gitsigns,
})

packadd({
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = conf.harpoon,
})
