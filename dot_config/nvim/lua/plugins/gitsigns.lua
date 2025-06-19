return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	opts = {
		current_line_blame = false,
		signs = {
			add = {
				text = "▍",
			},
			change = {
				text = "▍",
			},
			delete = {
				text = "▸",
			},
			topdelete = {
				text = "▾",
			},
			changedelete = {
				text = "▍",
			},
		},
	},
	keys = {
		{ "<leader>g", "", desc = "+git" },
		{ "<leader>gl", "<cmd>Gitsigns blame_line<cr>", desc = "Git blame" },
		{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },
		{ "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle_current_line_blame" },
		{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "preview_hunk" },
	},
	config = true,
}
