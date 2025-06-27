return {
	"rebelot/kanagawa.nvim",
	version = false,
	lazy = false,
	priority = 1000,
	opts = {
		{
			compile = true, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			theme = "wave", -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
			},
		},
	},
	config = function(_, opts)
		local theme = require("kanagawa")
		theme.setup(opts)
		theme.load()

		-- vim.cmd("colorscheme kanagawa")
	end,
}
