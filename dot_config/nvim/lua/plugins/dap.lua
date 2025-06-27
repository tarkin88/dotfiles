local function get_pyenv_venv_config()
	local handle = io.popen("pyenv version-name")
	if not handle then
		return nil
	end
	local venv = handle:read("*l")
	handle:close()
	if not venv or venv == "" then
		return nil
	end
	local pyenv_root = os.getenv("PYENV_ROOT") or (os.getenv("HOME") .. "/.pyenv")
	local full_venv_path = pyenv_root .. "/versions/" .. venv
	return full_venv_path .. "/bin/python"
end

-- Función para detectar si estamos en un proyecto Django
local function is_django_project()
	return vim.fn.filereadable("manage.py") == 1
end

-- Función para detectar archivo principal Python
local function find_main_python_file()
	local main_files = { "main.py", "app.py", "__main__.py", "run.py" }
	for _, file in ipairs(main_files) do
		if vim.fn.filereadable(file) == 1 then
			return vim.fn.getcwd() .. "/" .. file
		end
	end
	return vim.fn.expand("%:p") -- archivo actual como fallback
end

-- Función para iniciar Django con debugpy automáticamente
local function start_django_debug_server()
	local python_path = get_pyenv_venv_config() or "python"
	local cmd = string.format(
		"%s -m debugpy --listen 0.0.0.0:5678 --wait-for-client manage.py runserver 0.0.0.0:8000",
		python_path
	)

	vim.notify("🚀  Launching Django with debugpy on port:5678...", vim.log.levels.INFO)
	vim.notify("Commando: " .. cmd, vim.log.levels.DEBUG)

	-- Ejecutar en terminal flotante
	vim.cmd("split")
	vim.cmd("terminal " .. cmd)
	vim.cmd("resize 10")

	-- Esperar un memento y luego conectar automáticamente
	vim.defer_fn(function()
		vim.notify("🔌 Conectando debugger...", vim.log.levels.INFO)
		require("dap").run({
			type = "python",
			request = "attach",
			connect = {
				host = "127.0.0.1",
				port = 5678,
			},
			mode = "remote",
			name = "Attach to Django debugpy",
			justMyCode = false,
			django = true,
		})
	end, 3000) -- Esperar 3 segundos
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		-- Configuración de DAP Virtual Text
		dap_virtual_text.setup({
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			show_stop_reason = true,
			commented = false,
			only_first_definition = true,
			all_references = false,
			filter_references_pattern = "<module",
			virt_text_pos = "eol",
			all_frames = false,
			virt_lines = false,
			virt_text_win_col = nil,
		})
		vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#d7827e" })
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = " ", texthl = "DapBreakpointColor", linehl = "", numhl = "DapBreakpointColor" }
		)
		-- Configuración de DAP UI
		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.50 },
						{ id = "watches", size = 0.30 },
						{ id = "stacks", size = 0.08 },
						{ id = "breakpoints", size = 0.12 },
					},
					size = 50,
					position = "left",
				},
				{
					elements = {
						{ id = "repl", size = 0.6 },
						{ id = "console", size = 0.4 },
					},
					size = 10,
					position = "bottom",
				},
			},
		})

		-- Eventos para abrir/cerrar DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Configurar Python path
		local python_path = get_pyenv_venv_config()
		if python_path then
			dap_python.setup(python_path)
		else
			dap_python.setup()
		end

		-- Keymaps mejorados
		vim.keymap.set("n", "<F9>", dap.continue, { desc = "Start/Continue Debug" })

		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
		vim.keymap.set("n", "<F8>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })

		-- Keymaps adicionales
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Conditional Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart" })
		vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

		-- Commandos personalizados
		vim.api.nvim_create_user_command("DapAttach", function()
			dap.run(dap.configurations.python[2]) -- Django Remote Attach
		end, { desc = "Attach to Django debugpy" })

		vim.api.nvim_create_user_command("DapDjango", function()
			if is_django_project() then
				dap.run(dap.configurations.python[1]) -- Django Auto-Debug
			else
				vim.notify("❌ No es un proyecto Django", vim.log.levels.ERROR)
			end
		end, { desc = "Debug Django project" })

		vim.api.nvim_create_user_command("DapDjangoRemote", function()
			if is_django_project() then
				start_django_debug_server()
			else
				vim.notify("❌ Isn't a Django project", vim.log.levels.ERROR)
			end
		end, { desc = "Start Django with debugpy and auto-attach" })

		vim.api.nvim_create_user_command("DapTest", function()
			if is_django_project() then
				dap.run(dap.configurations.python[4]) -- Django Tests
			else
				dap.run(dap.configurations.python[5]) -- Pytest
			end
		end, { desc = "Debug tests" })

		vim.api.nvim_create_user_command("DapFile", function()
			dap.run(dap.configurations.python[3]) -- Current File
		end, { desc = "Debug current file" })
	end,
}
