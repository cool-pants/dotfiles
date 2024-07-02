local api = vim.api
local map = require("core.keymap")
local cmd = map.cmd

map.n({
	-- basics
	["<Esc>"] = cmd("nohlsearch"),
	["<C-s>"] = cmd("write"),

	-- disable arrow keys in normal mode
	["<Left>"] = cmd('echo "Use h to move!!"'),
	["<Right>"] = cmd('echo "Use l to move!!"'),
	["<Up>"] = cmd('echo "Use k to move!!"'),
	["<Down>"] = cmd('echo "Use j to move!!"'),

	-- window
	["<C-h>"] = "<C-w><C-h>",
	["<C-l>"] = "<C-w><C-l>",
	["<C-j>"] = "<C-w><C-j>",
	["<C-k>"] = "<C-w><C-k>",
	["<A-[>"] = cmd("vertical resize -5"),
	["<A-]>"] = cmd("vertical resize +5"),

	-- Magic motions to move stuff around
	["<A-j>"] = cmd("m .+1"),
	["<A-k>"] = cmd("m .-2"),

	-- Move around with cursor at center
	["<A-d>"] = "<C-d>zz",
	["<A-u>"] = "<C-u>zz",

	-- Search around with search term at center
	["n"] = "nzzzv",
	["N"] = "Nzzzv",

	-- Greatest remap courtesy : asbjornHaland. Yank to clipboard
	["<leader>Y"] = [["+Y]],

	-- cool replace all occurances of word in file
	["<leader>s"] = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Lf>]],

	-- source current file
	["<leader><leader>"] = cmd("so"),

	-- highlights under cursor
	["<leader>ui"] = vim.show_pos,
	["<leader>uI"] = "<cmd>InspectTree<cr>",
})

map.nv({
	-- Greatest remap courtesy : asbjornHaland. Yank to clipboard
	["<leader>y"] = [["+y]],
})

map.i({
	["<C-s>"] = cmd("write"),

	["<C-d>"] = "<C-o>ciw",
	-- insert down/up
	["<C-j>"] = "<C-o>o",
	["<C-k>"] = "<C-o>O",
	--@see https://github.com/neovim/neovim/issues/16416
	["<C-C>"] = "<C-C>",

	-- Magic motions to move stuff around
	["<A-j>"] = "<esc><cmd>m .+1<cr>==gi",
	["<A-k>"] = "<esc><cmd>m .-2<cr>==gi",
})

map.v({
	["<A-j>"] = ":m '>+1<cr>gv=gv",
	["<A-k>"] = ":m '<-2<cr>gv=gv",
	["<"] = "<gv",
	[">"] = ">gv",
})

map.x({
	-- Greatest remap ever!! Paste while keeping current data in bufr
	["<leader>p"] = [["_dP]],
})

map.i("<C-n>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	elseif vim.snippet.active({ direction = 1 }) then
		return "<cmd>lua vim.snippet.jump(1)<cr>"
	else
		return "<TAB>"
	end
end, { expr = true })

map.i("<C-p>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	elseif vim.snippet.active({ direction = -1 }) then
		return "<cmd>lua vim.snippet.jump(-1)<CR>"
	else
		return "<S-TAB>"
	end
end, { expr = true })

map.i("<A-CR>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>" or _G.PairMate.cr()
end, { expr = true })

map.i("<C-e>", function()
	if vim.fn.pumvisible() == 1 then
		require("epo").disable_trigger()
		return "<c-e>"
	else
		return "<End>"
	end
end, { expr = true })

local ns_id, mark_id = vim.api.nvim_create_namespace("my_marks"), nil

map.i("<C-t>", function()
	if not mark_id then
		local row, col = unpack(api.nvim_win_get_cursor(0))
		mark_id = api.nvim_buf_set_extmark(0, ns_id, row - 1, col, { id = 1, hl_group = "IncSearch" })
		return
	end
	local mark = api.nvim_buf_get_extmark_by_id(0, ns_id, mark_id, {})
	if not mark or #mark == 0 then
		return
	end
	api.nvim_win_set_cursor(0, { mark[1] + 1, mark[2] })
	api.nvim_buf_del_extmark(0, ns_id, mark_id)
	mark_id = nil
end)
