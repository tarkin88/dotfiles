return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"fang2hou/blink-copilot",
	},
	build = "cargo build --release",
	opts = {
		keymap = { preset = "super-tab" },
		appearance = {
			nerd_font_variant = "normal",
		},
		completion = {
			documentation = { auto_show = false },
			ghost_text = {
				enabled = true,
				show_with_menu = false,
			},
			menu = { auto_show = false },
		},
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
				cmdline = {
					-- ignores cmdline completions when executing shell commands
					enabled = function()
						return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
					end,
				},
			},
		},
		fuzzy = { implementation = "rust" },
	},
	opts_extend = { "sources.default" },
}
