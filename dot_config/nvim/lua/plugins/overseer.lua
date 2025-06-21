return {
	"stevearc/overseer.nvim",
	cmd = "OverseerRun",
	config = function(_, opts)
		require("overseer").setup(opts)
		require("overseer").register_template(require("tasks.django_debug"))
	end,
	keys = {
		{ "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Toggle Task List" },
		{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
	},
}
