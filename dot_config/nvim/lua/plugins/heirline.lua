return {
	"rebelot/heirline.nvim",
	config = function()
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		-- Rose Pine Dawn colors
		local colors = {
			-- Base colors
			base = "#faf4ed",
			surface = "#fffaf3",
			overlay = "#f2e9e1",
			muted = "#9893a5",
			subtle = "#797593",
			text = "#575279",

			-- Accent colors
			love = "#b4637a",
			gold = "#ea9d34",
			rose = "#d7827e",
			pine = "#286983",
			foam = "#56949f",
			iris = "#907aa9",

			-- Status colors
			bright_bg = "#f2e9e1",
			bright_fg = "#575279",
			red = "#b4637a",
			dark_red = "#b4637a",
			green = "#286983",
			blue = "#56949f",
			gray = "#9893a5",
			orange = "#ea9d34",
			purple = "#907aa9",
			cyan = "#56949f",
			diag_warn = "#ea9d34",
			diag_error = "#b4637a",
			diag_hint = "#907aa9",
			diag_info = "#56949f",
			git_del = "#b4637a",
			git_add = "#286983",
			git_change = "#ea9d34",
		}

		-- Vi Mode
		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = {
					n = "N",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "V",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "I",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "C",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				},
				mode_colors = {
					n = "love",
					i = "foam",
					v = "iris",
					V = "iris",
					["\22"] = "iris",
					c = "gold",
					s = "rose",
					S = "rose",
					["\19"] = "rose",
					R = "gold",
					r = "gold",
					["!"] = "love",
					t = "pine",
				},
			},
			provider = function(self)
				return " %2(" .. self.mode_names[self.mode] .. "%)"
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = self.mode_colors[mode], bold = true }
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		-- File name
		local FileName = {
			provider = function()
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
				if filename == "" then
					return "[No Name]"
				end
				return filename
			end,
			hl = { fg = colors.foam },
		}

		-- File flags
		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = " ●",
				hl = { fg = colors.pine },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = " ",
				hl = { fg = colors.gold },
			},
		}

		-- Git
		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			hl = { fg = colors.subtle },
			{
				provider = function(self)
					return "  " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "(",
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("+" .. count)
				end,
				hl = { fg = colors.git_add },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("-" .. count)
				end,
				hl = { fg = colors.git_del },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("~" .. count)
				end,
				hl = { fg = colors.git_change },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = ")",
			},
		}

		-- LSP
		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },
			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
			hl = { fg = colors.pine, bold = true },
		}

		-- Diagnostics
		local Diagnostics = {
			condition = conditions.has_diagnostics,
			static = {
				error_icon = " ",
				warn_icon = " ",
				info_icon = " ",
				hint_icon = " ",
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			{
				provider = function(self)
					return self.errors > 0 and (self.error_icon .. self.errors .. " ")
				end,
				hl = { fg = colors.diag_error },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
				end,
				hl = { fg = colors.diag_warn },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. " ")
				end,
				hl = { fg = colors.diag_info },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints)
				end,
				hl = { fg = colors.diag_hint },
			},
		}

		-- File type and position
		local FileType = {
			provider = function()
				return string.upper(vim.bo.filetype)
			end,
			hl = { fg = colors.text, bold = true },
		}

		local Ruler = {
			provider = "%l:%c %P",
			hl = { fg = colors.subtle },
		}

		-- Align component
		local Align = { provider = "%=" }
		local Space = { provider = " " }

		-- STATUSLINE
		local StatusLine = {
			ViMode,
			Space,
			FileName,
			FileFlags,
			Space,
			Git,
			Align,
			Diagnostics,
			Space,
			LSPActive,
			Space,
			FileType,
			Space,
			Ruler,
			Space,
		}

		-- TABLINE (BufferLine)
		local TablineBufnr = {
			provider = function(self)
				return tostring(self.bufnr) .. ". "
			end,
			hl = { fg = colors.muted },
		}

		local TablineFileName = {
			provider = function(self)
				local filename = self.filename
				filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
				return filename
			end,
			hl = function(self)
				return { bold = self.is_active or self.is_visible, italic = true }
			end,
		}

		local TablineFileFlags = {
			{
				condition = function(self)
					return vim.api.nvim_buf_get_option(self.bufnr, "modified")
				end,
				provider = " ●",
				hl = { fg = colors.pine },
			},
			{
				condition = function(self)
					return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
						or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
				end,
				provider = function(self)
					if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
						return "  "
					else
						return " "
					end
				end,
				hl = { fg = colors.gold },
			},
		}

		local TablineFileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(self.bufnr)
			end,
			hl = function(self)
				if self.is_active then
					return "TabLineSel"
				else
					return "TabLine"
				end
			end,
			on_click = {
				callback = function(_, minwid, _, _)
					vim.api.nvim_win_set_buf(0, minwid)
				end,
				minwid = function(self)
					return self.bufnr
				end,
				name = "heirline_tabline_buffer_callback",
			},
			TablineBufnr,
			TablineFileName,
			TablineFileFlags,
		}

		local TablineCloseButton = {
			condition = function(self)
				return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
			end,
			{ provider = " " },
			{
				provider = "×",
				hl = { fg = colors.muted },
				on_click = {
					callback = function(_, minwid, _, _)
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
							vim.cmd.redrawtabline()
						end)
					end,
					minwid = function(self)
						return self.bufnr
					end,
					name = "heirline_tabline_close_buffer_callback",
				},
			},
		}

		local TablineBufferBlock = utils.surround({ "", "" }, function(self)
			if self.is_active then
				return utils.get_highlight("TabLineSel").bg
			else
				return utils.get_highlight("TabLine").bg
			end
		end, { TablineFileNameBlock, TablineCloseButton })

		local BufferLine = utils.make_buflist(
			TablineBufferBlock,
			{ provider = "", hl = { fg = colors.muted } },
			{ provider = "", hl = { fg = colors.muted } }
		)

		local Tabpage = {
			provider = function(self)
				return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
			end,
			hl = function(self)
				if not self.is_active then
					return "TabLine"
				else
					return "TabLineSel"
				end
			end,
		}

		local TabpageClose = {
			provider = "%999X  %X",
			hl = "TabLine",
		}

		local TabPages = {
			condition = function()
				return #vim.api.nvim_list_tabpages() >= 2
			end,
			{ provider = "%=" },
			utils.make_tablist(Tabpage),
			TabpageClose,
		}

		local TabLine = {
			BufferLine,
			TabPages,
		}

		-- Setup
		heirline.setup({
			statusline = StatusLine,
			tabline = TabLine,
			opts = {
				colors = colors,
			},
		})
	end,
}
