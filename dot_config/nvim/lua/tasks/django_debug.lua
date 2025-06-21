local overseer = require("overseer")

return {
	name = "Django Dev with debugpy (auto attach)",
	builder = function()
		return {
			cmd = { "python" },
			args = {
				"-Xfrozen_modules=off",
				"-m",
				"debugpy",
				"--listen",
				"5678",
				"manage.py",
				"runserver",
				"0.0.0.0:8000",
				"--nothreading",
				"--noreload",
			},
			components = {
				"default",
				{
					"on_output_parse",
					-- 👇 configuración del componente
					opts = {
						parser = function(line, _)
							if line:match("5678") or line:match("Listening for client connections") then
								vim.schedule(function()
									vim.notify("🔌 Conectando a debugpy...", vim.log.levels.INFO)
									require("dap").run({
										type = "python",
										request = "attach",
										connect = {
											host = "127.0.0.1",
											port = 5678,
										},
										mode = "remote",
										name = "Auto attach Django debugpy",
										justMyCode = false,
									})
								end)
								return true
							end
							return false
						end,
					},
				},
			},
			env = {
				DJANGO_SETTINGS_MODULE = "config.settings.local",
				PYTHONBREAKPOINT = "debugpy.breakpoint",
			},
		}
	end,
	tags = { "django", "debug" },
}
