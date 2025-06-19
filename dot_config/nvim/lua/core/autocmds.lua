-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = visual_aid,
	callback = function()
		vim.highlight.on_yank({
			higroup = "Visual",
			timeout = 300,
			on_visual = false,
		})
	end,
})

-- activate cursorline when entering a window
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = visual_aid,
	callback = function()
		vim.cmd("setlocal cursorline")
	end,
})

-- deactivate cursorline when leaving a window
vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
	group = visual_aid,
	callback = function()
		vim.cmd("setlocal nocursorline")
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_user_command("Vr", function(opts)
	local usage = "Usage: [VirticalResize] :Vr {number (%)}"
	if not opts.args or not string.len(opts.args) == 2 then
		print(usage)
		return
	end
	vim.cmd(":vertical resize " .. vim.opt.columns:get() * (opts.args / 100.0))
end, { nargs = "*" })

vim.api.nvim_create_user_command("Hr", function(opts)
	local usage = "Usage: [HorizontalResize] :Hr {number (%)}"
	if not opts.args or not string.len(opts.args) == 2 then
		print(usage)
		return
	end
	vim.cmd(":resize " .. ((vim.opt.lines:get() - vim.opt.cmdheight:get()) * (opts.args / 100.0)))
end, { nargs = "*" })
