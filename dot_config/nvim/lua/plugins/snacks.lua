return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		styles = {
			zen = {
				enter = true,
				fixbuf = false,
				minimal = false,
				width = 130,
				height = 30,
				backdrop = { transparent = true, blend = 30 },
				keys = { q = false },
				zindex = 40,
				wo = {
					winhighlight = "NormalFloat:Normal",
				},
				w = {
					snacks_main = true,
				},
			},
		},
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
				{ section = "recent_files", cwd = true, limit = 8, padding = 1 },
				{ title = "MRU", padding = 1 },
				{ section = "recent_files", limit = 8, padding = 1 },
				{ section = "startup" },
			},
		},
		bufdelete = { enabled = true },
		dim = { enabled = true },
		explorer = { enabled = false, replace_netrw = true },
		git = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			matcher = {
				fuzzy = true, -- use fuzzy matching
				smartcase = true, -- use smartcase
				ignorecase = true, -- use ignorecase
				frecency = true, -- frecency bonus
				history_bonus = true, -- give more weight to chronological order
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = {
			enabled = true,
			terminal = { enabled = true },
			folds = {
				open = true, -- show open fold icons
			},
		},
		words = { enabled = true },
		zen = { enabled = true, toggles = {
			dim = true,
			inlay_hints = true,
		} },
	},
	keys = {
		-- {
		-- 	"<F1>",
		-- 	function()
		-- 		Snacks.explorer.open()
		-- 	end,
		-- 	desc = "Open file explorer",
		-- },
		{
			"<F4>",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Blame [L]ine",
		},
		{
			"<leader>fz",
			function()
				Snacks.zen.zen()
			end,
			desc = "Toggle [Z]en mode",
		},

		-- files
		{
			"<C-p>",
			function()
				Snacks.picker("files")
			end,
			desc = "[F]iles",
		},
		{
			"<F3>",
			function()
				Snacks.picker("recent")
			end,
			desc = "[F]iles",
		},
		-- LSP
		{
			"<F2>",
			function()
				Snacks.picker("diagnostics_buffer")
			end,
			desc = "",
		},
		{
			"<F7>",
			function()
				Snacks.picker("lsp_symbols")
			end,
			desc = "[S]symbols",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- general
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- buffer delete
		{
			"<A-down>",
			function()
				Snacks.bufdelete()
			end,
			desc = "Buffer [D]elete",
		},
	},
}
