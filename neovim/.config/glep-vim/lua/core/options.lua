local api, opt, g = vim.api, vim.opt, vim.g
g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Sets how neowill display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

opt.termguicolors = true
opt.hlsearch = true

-- fold options
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.foldlevel = 99

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldexpr = "nvim_treesitter#foldexpr()"
	opt.foldmethod = "expr"
	opt.foldtext = ""
else
	opt.foldmethod = "indent"
	opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

opt.hidden = true
opt.magic = true
opt.virtualedit = "block"
opt.wildignorecase = true
opt.swapfile = false
opt.breakindent = true

opt.history = 1000
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.cursorline = true

-- opt.completeopt = "menu,menuone,noinsert,fuzzy"
opt.showmode = false
opt.shortmess = "aoOTIcF"
opt.scrolloff = 2
opt.sidescrolloff = 5
opt.ruler = false
opt.showtabline = 0
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false

opt.cmdheight = 0
opt.laststatus = 3
opt.list = true

--eol:¬
opt.listchars = "tab:» ,nbsp:+,trail:·,extends:→,precedes:←,"
opt.pumblend = 10
opt.winblend = 0
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.foldlevelstart = 99
opt.foldmethod = "marker"

opt.splitright = true
opt.splitbelow = true
opt.wrap = false

opt.number = true
opt.relativenumber = true
opt.nu = true
opt.signcolumn = "yes"
opt.spelloptions = "camel"

opt.textwidth = 80
opt.colorcolumn = "+0"

local function get_signs(name)
	return function()
		local bufnr = api.nvim_win_get_buf(vim.g.statusline_winid)
		local it = vim.iter(api.nvim_buf_get_extmarks(bufnr, -1, 0, -1, { details = true, type = "sign" }))
			:find(function(item)
				return item[2] == vim.v.lnum - 1 and item[4].sign_hl_group and item[4].sign_hl_group:find(name)
			end)
		return not it and "  " or ("%%#%s#%s%%*"):format(it[4].sign_hl_group, it[4].sign_text)
	end
end

function _G.show_stc()
	local stc_diagnostic = get_signs("Diagnostic")
	local stc_gitsign = get_signs("GitSign")

	local function show_break()
		if vim.v.virtnum > 0 then
			return (" "):rep(math.floor(math.ceil(math.log10(vim.v.lnum))) - 1) .. "↳"
		end
		return vim.v.virtnum < 0 and "" or vim.v.lnum
	end
	return ("%s%%=%s%s"):format(stc_diagnostic(), show_break(), stc_gitsign())
end

vim.opt.stc = "%!v:lua.show_stc()"

if vim.uv.os_uname().sysname == "Darwin" then
	vim.g.clipboard = {
		name = "macOS-clipboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
		cache_enabled = 0,
	}
end
