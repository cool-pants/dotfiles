require("keymap.remap")
local map = require("core.keymap")
local flash = require("flash")
local cmd = map.cmd

local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

map.n({
	-- Lspsaga
	["<leader>q"] = vim.diagnostic.setloclist,
	["<leader>cd"] = vim.diagnostic.open_float,
	["]d"] = diagnostic_goto(true),
	["[d"] = diagnostic_goto(false),
	["]e"] = diagnostic_goto(true, "ERROR"),
	["[e"] = diagnostic_goto(false, "ERROR"),
	["]w"] = diagnostic_goto(true, "WARN"),
	["[w"] = diagnostic_goto(false, "WARN"),
	["K"] = cmd("Lspsaga hover_doc"),
	["ga"] = cmd("Lspsaga code_action"),
	["gR"] = cmd("Lspsaga rename"),
	["gD"] = cmd("Lspsaga peek_definition"),
	["gh"] = cmd("Lspsaga finder"),
	-- Telescope builtin
	["gd"] = require("telescope.builtin").lsp_definitions,
	["gr"] = require("telescope.builtin").lsp_references,
	["gI"] = require("telescope.builtin").lsp_implementations,

	["<Leader>o"] = cmd("Lspsaga outline"),
	["<Leader>dw"] = cmd("show_workspace_diagnostics"),
	["<Leader>db"] = cmd("Lspsaga show_buf_diagnostics"),
	-- Telescope
	["<Leader>fa"] = cmd("Telescope live_grep"),
	["<Leader>fs"] = cmd("Telescope grep_string"),
	["<Leader>ff"] = cmd("Telescope find_files find_command=rg,--ignore,--hidden,--files"),
	["<Leader>fg"] = cmd("Telescope git_files"),
	["<Leader>T"] = cmd("Telescope colorscheme"),
	-- find in workspace folder which is project dir
	["<Leader>fw"] = cmd("Telescope find_files cwd=$HOME/personal" .. "find_command=rg,--ignore,--hidden,--files"),
	["<Leader>fh"] = cmd("Telescope help_tags"),
	["<Leader>gc"] = cmd("Telescope git_commits"),
	["<Leader>fd"] = cmd("Telescope dotfiles"),
	-- Oil
	["-"] = cmd("Oil"),
	-- Trouble
	["<Leader>xx"] = cmd("Trouble diagnostics toggle"),
	["<Leader>xX"] = cmd("Trouble diagnostics toggle filter.buf=0"),
	["<Leader>cs"] = cmd("Trouble symbols toggle focus=false"),
	["<Leader>cl"] = cmd("Trouble lsp toggle focus=false win.position=right"),
	["<Leader>xL"] = cmd("Trouble loclist toggle"),
	["<Leader>xQ"] = cmd("Trouble qflist toggle"),
	-- Harpoon
	["<Leader>H"] = function()
		require("harpoon"):list():add()
	end,
	["<Leader>h"] = function()
		local harpoon = require("harpoon")
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end,
})

-- for i = 1, 5 do
-- 	map.n["<Leader>" .. i] = function()
-- 		require("harpoon"):list():select(i)
-- 	end
-- end

map.nxo({
	["s"] = function()
		flash.jump()
	end,
	["S"] = function()
		flash.treesitter()
	end,
})
