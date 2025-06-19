local function get_pyenv_venv_config()
	local handle = io.popen("pyenv version-name")
	if not handle then
		return {}
	end

	local venv = handle:read("*l")
	handle:close()

	if not venv or venv == "" then
		return {}
	end

	local pyenv_root = os.getenv("PYENV_ROOT") or (os.getenv("HOME") .. "/.pyenv")
	local full_venv_path = pyenv_root .. "/versions/" .. venv

	return {
		analysis = {
			reportMissingImports = true,
			typeCheckingMode = "basic",
			autoSearchPaths = true,
			diagnosticMode = "openFilesOnly",
			useLibraryCodeForTypes = true,
			extraPaths = { full_venv_path .. "/lib/python3.12/site-packages" },
		},
		venv = venv,
		venvPath = pyenv_root .. "/versions",
	}
end

return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp", "b0o/schemastore.nvim" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local lspconfig = require("lspconfig")

		require("lspconfig.ui.windows").default_options.border = "rounded"

		local servers = {
			basedpyright = {
				settings = {
					basedpyright = get_pyenv_venv_config(),
				},
			},
			bashls = {},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
			lua_ls = {},
			ruff = {
				init_options = {
					settings = {
						organizeImports = false,
						enable = true,
						ignoreStandardLibrary = true,
						fixAll = true,
						lint = {
							enable = true,
							run = "onType",
						},
					},
				},
			},
			yamlls = {},
		}

		local diagnostics = {
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			signs = {
				active = true,
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		}
		vim.diagnostic.config(diagnostics)

		for server, opts in pairs(servers) do
			opts.capabilities = vim.tbl_deep_extend("force", capabilities, opts.capabilities or {})
			lspconfig[server].setup(opts)
		end
	end,
}
