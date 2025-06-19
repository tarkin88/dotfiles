return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {},
	event = { "BufReadPost", "BufNewFile" },
	cmd = {
		"TSBufDisable",
		"TSBufEnable",
		"TSBufToggle",
		"TSDisable",
		"TSEnable",
		"TSToggle",
		"TSInstall",
		"TSInstallInfo",
		"TSInstallSync",
		"TSModuleInfo",
		"TSUninstall",
		"TSUpdate",
		"TSUpdateSync",
	},
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",

	config = function()
		local success, treesitter = pcall(require, "nvim-treesitter.configs")
		if not success then
			vim.notify("Failed to load plugin: treesitter")
			return
		end

		treesitter.setup({
			ensure_installed = {
				"bash",
				"cpp",
				"diff",
				"dockerfile",
				"json",
				"jsonc",
				"gitcommit",
				"lua",
				"markdown",
				"python",
				"query",
				"yaml",
			},
			ignore_install = {},
			highlight = {
				enable = true,
				disable = { "markdown" },
			},
			indent = { enable = true, disable = { "css", "latex" } },
			fold = { enable = true },
		})

		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "nvim_treesitter#foldexpr()"
	end,
}
