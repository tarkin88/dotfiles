return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
		},
		skip_confirm_for_simple_edits = true,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
		float = {
			-- Padding around the floating window
			-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			max_width = 0.4,
			max_height = 0.9,
			border = "rounded",
			get_win_title = nil,
			preview_split = "below",
		},
		keymaps = {
			["g?"] = { "actions.show_help", mode = "n" },
			["<CR>"] = "actions.select",
			["<C-v>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = { "actions.select", opts = { horizontal = true } },
			["<C-t>"] = { "actions.select", opts = { tab = true } },
			["<C-p>"] = "actions.preview",
			["<C-c>"] = { "actions.close", mode = "n" },
			["<C-l>"] = "actions.refresh",
			["-"] = { "actions.parent", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
			["`"] = { "actions.cd", mode = "n" },
			["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
			["gs"] = { "actions.change_sort", mode = "n" },
			["gx"] = "actions.open_external",
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["g\\"] = { "actions.toggle_trash", mode = "n" },
		},
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	config = true,
	keys = {
		{
			"<leader>e",
			"<cmd>Oil --float <cr>",
			desc = "Open Mini Files",
		},
	},
}
