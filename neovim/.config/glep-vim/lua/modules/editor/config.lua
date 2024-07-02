local config = {}
local git_ignored = setmetatable({}, {
	__index = function(self, key)
		local proc = vim.system({ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }, {
			cwd = key,
			text = true,
		})
		local result = proc:wait()
		local ret = {}
		if result.code == 0 then
			for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
				-- Remove trailing slash
				line = line:gsub("/$", "")
				table.insert(ret, line)
			end
		end

		rawset(self, key, ret)
		return ret
	end,
})

function config.telescope()
	local function flash(prompt_bufnr)
		require("flash").jump({
			pattern = "^",
			label = { after = { 0, 0 } },
			search = {
				mode = "search",
				exclude = {
					function(win)
						return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
					end,
				},
			},
			action = function(match)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				picker:set_selection(match.pos[1] - 1)
			end,
		})
	end
	require("telescope").setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = "➤ ",
			layout_config = {
				horizontal = { prompt_position = "top", results_width = 0.6 },
				vertical = { mirror = false },
			},
			sorting_strategy = "ascending",
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			mapping = {
				n = {
					s = flash,
				},
				i = {
					["<A-s>"] = flash,
				},
			},
			file_ignore_patterns = {
				"node_modules",
				"venv",
				".venv",
				".git/",
				"__pycache__",
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})
	require("telescope").load_extension("dotfiles")
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")
end

function config.nvim_treesitter()
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	require("nvim-treesitter.configs").setup({
		sync_install = false,
		auto_install = true,
		modules = {},
		ignore_install = {},
		ensure_installed = {
			"python",
			"bash",
			"lua",
			"luadoc",
			"vim",
			"vimdoc",

			"go",
			"gomod",
			"gosum",
			"gowork",
			"gotmpl",
			"proto",

			"c",
			"cpp",
			"zig",
			"rust",

			"html",
			"typescript",
			"javascript",
			"css",
			"scss",
			"json",
			"jsonc",
			"tsx",
			"graphql",
			"markdown",
			"markdown_inline",
			"yaml",

			"diff",
			"gitignore",
			"cmake",
			"dockerfile",
			"sql",
		},
		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 240 * 1024
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
	})

	--set indent for jsx tsx
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "javascriptreact", "typescriptreact" },
		callback = function(opt)
			vim.bo[opt.buf].indentexpr = "nvim_treesitter#indent()"
		end,
	})
end

function config.nvim_treesitter_context()
	local tsc = require("treesitter-context")
	tsc.setup({
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = true,
		multiline_threshold = 5, -- Maximum number of lines to show for a single context
		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 20, -- The Z-index of the context window
		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	})
end

function config.ts_autotag()
	require("nvim-ts-autotag").setup({
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
		-- Also override individual filetype configs, these take priority.
		-- Empty by default, useful if one of the "opts" global settings
		-- doesn't work well in a specific filetype
		per_filetype = {
			["html"] = {
				enable_close = false,
			},
		},
	})
end

function config.oil()
	require("oil").setup({
		view_options = {
			is_hidden_file = function(name, _)
				local dir = require("oil").get_current_dir()
				-- if not local directory (e.g. for ssh connections), always show
				if not dir then
					return false
				end
				-- check if file is gitignored
				return vim.list_contains(git_ignored[dir], name)
			end,
		},
		default_file_explorer = true,
		columns = {
			"icon",
			"permission",
			"size",
		},
		preview = {
			-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a single value or a list of mixed integer/float types.
			-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
			max_width = 0.9,
			-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
			min_width = { 40, 0.4 },
			-- optionally define an integer/float for the exact width of the preview window
			width = nil,
			-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_height and max_height can be a single value or a list of mixed integer/float types.
			-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
			max_height = 0.9,
			-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
			min_height = { 5, 0.1 },
			-- optionally define an integer/float for the exact height of the preview window
			height = nil,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			-- Whether the preview window is automatically updated when the cursor is moved
			update_on_cursor_moved = true,
		},
	})
end

function config.mini()
	-- Better Around/Inside textobjects
	--
	-- Examples:
	--  - va)  - [V]isually select [A]round [)]paren
	--  - yinq - [Y]ank [I]nside [N]ext [']quote
	--  - ci'  - [C]hange [I]nside [']quote

	require("mini.ai").setup({
		n_lines = 500,
	})
	-- Add/delete/replace surroundings (brackets, quotes, etc.)
	--
	-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
	-- - sd'   - [S]urround [D]elete [']quotes
	-- - sr)'  - [S]urround [R]eplace [)] [']

	require("mini.surround").setup()

	local hipatterns = require("mini.hipatterns")
	hipatterns.setup({
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

			-- Highlight hex color strings (`#rrggbb`) using that color
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end

function config.conform()
	require("conform").setup({
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				-- have a well standardized coding style. You can add additional
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			javascript = { "prettier", "prettierd" },
			typescript = { "prettier", "prettierd" },
			javascriptreact = { "prettier", "prettierd" },
			typescriptreact = { "prettier", "prettierd" },
			svelte = { "prettier", "prettierd" },
			css = { "prettier", "prettierd" },
			html = { "prettier", "prettierd" },
			json = { "prettier", "prettierd" },
			yaml = { "prettier", "prettierd" },
			markdown = { "prettier", "prettierd" },
			graphql = { "prettier", "prettierd" },
			lua = { "stylua" },
			python = { "isort", "black" },
		},
	})
end

return config
