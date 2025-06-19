return {
	"rose-pine/neovim",
	name = "rose-pine",
	version = false,
	lazy = false,
	priority = 1000,
	opts = {
		variant = "dawn",
	},
	config = function(_, opts)
		local theme = require("rose-pine")
		theme.setup(opts)
		-- theme.load()

		vim.cmd("colorscheme rose-pine-dawn")
	end,
}
