-- Theme
-- vim.g.default_colorscheme = "tokyonight-night"
-- Options --------------------------------------------------------------------
vim.opt.breakindent = true -- Wrap indent to match  line start.
-- vim.opt.clipboard = "unnamedplus" -- Connection to the system clipboard.
vim.opt.cmdheight = 0 -- Hide command line unless needed.
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion.
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting.
vim.opt.cursorline = true -- Highlight the text line of the cursor.
vim.opt.expandtab = true -- Enable the use of space in tab.
vim.opt.fileencoding = "utf-8" -- File content encoding for the buffer.
vim.opt.ignorecase = true -- Case insensitive searching.
vim.opt.infercase = true -- Infer cases in keyword completion.
vim.opt.foldenable = false -- fold
vim.opt.foldlevel = 99 -- set highest foldlevel
vim.opt.foldlevelstart = 2 -- Start with all code unfolded.
vim.opt.foldcolumn = "4" -- Show foldcolumn in nvim 0.9+.
-- vim.opt.foldcolumn = "auto:4" -- Show foldcolumn in nvim 0.9+.

vim.opt.laststatus = 3 -- Global statusline.
vim.opt.linebreak = true -- Wrap lines at 'breakat'.
vim.opt.number = true -- Show numberline.
vim.opt.preserveindent = true -- Preserve indent structure as much as possible.
vim.opt.pumheight = 10 -- Height of the pop up menu.
vim.opt.relativenumber = true -- Show relative numberline.
vim.opt.shiftwidth = 2 -- Number of space inserted for indentation.
vim.opt.showmode = false -- Disable showing modes in command line.
vim.opt.showtabline = 2 -- always display tabline.
vim.opt.signcolumn = "yes" -- Always show the sign column.
vim.opt.smartcase = true -- Case sensitivie searching.
vim.opt.smartindent = false -- Smarter autoindentation.
vim.opt.splitbelow = true -- Splitting a new window below the current one.
vim.opt.splitright = true -- Splitting a new window at the right of the current one.
vim.opt.tabstop = 2 -- Number of space in a tab.

vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI.
vim.opt.undofile = true -- Enable persistent undo between session and reboots.
vim.opt.updatetime = 300 -- Length of time to wait before triggering the plugin.
vim.opt.virtualedit = "block" -- Allow going past end of line in visual block mode.
vim.opt.writebackup = false -- Disable making a backup before overwriting a file.
vim.opt.shada = "!,'1000,<50,s10,h" -- Remember the last 1000 opened files
vim.opt.history = 1000 -- Number of commands to remember in a history table (per buffer).
vim.opt.swapfile = false -- Ask what state to recover when opening a file that was not saved.
vim.opt.wrap = true -- Disable wrapping of lines longer than the width of window.
vim.opt.colorcolumn = "120" -- PEP8 like character limit vertical bar.
vim.opt.mousescroll = "ver:1,hor:0" -- Disables hozirontal scroll in neovim.
vim.opt.guicursor = "n:blinkon200,i-ci-ve:ver25" -- Enable cursor blink.
vim.opt.autochdir = false -- Use current file dir as working dir (See project.nvim).
vim.opt.scrolloff = 1000 -- Number of lines to leave before/after the cursor when scrolling. Setting a high value keep the cursor centered.
vim.opt.sidescrolloff = 8 -- Same but for side scrolling.
vim.opt.selection = "old" -- Don't select the newline symbol when using <End> on visual mode.

vim.opt.viewoptions:remove("curdir") -- Disable saving current directory with views.
-- vim.opt.shortmess:append({ s = true, I = true }) -- Disable startup message.
vim.opt.shortmess = table.concat({ -- Use abbreviations and short messages in command menu line.
	"f", -- Use "(3 of 5)" instead of "(file 3 of 5)".
	"i", -- Use "[noeol]" instead of "[Incomplete last line]".
	"l", -- Use "999L, 888C" instead of "999 lines, 888 characters".
	"m", -- Use "[+]" instead of "[Modified]".
	"n", -- Use "[New]" instead of "[New File]".
	"r", -- Use "[RO]" instead of "[readonly]".
	"w", -- Use "[w]", "[a]" instead of "written", "appended".
	"x", -- Use "[dos]", "[unix]", "[mac]" instead of "[dos format]", "[unix format]", "[mac format]".
	"o", -- Overwrite message for writing a file with subsequent message.
	"O", -- Message for reading a file overwrites any previous message.
	"s", -- Disable "search hit BOTTOM, continuing at TOP" such messages.
	"t", -- Truncate file message at the start if it is too long.
	"T", -- Truncate other messages in the middle if they are too long.
	"I", -- Don't give the :intro message when starting.
	"c", -- Don't give ins-completion-menu messages.
	"F", -- Don't give the file info when editing a file.
})
vim.opt.backspace:append({ "nostop" }) -- Don't stop backspace at insert.
vim.opt.diffopt:append({ "algorithm:histogram", "linematch:60" }) -- Enable linematch diff algorithm
vim.opt.mouse = "a"

-- Globals --------------------------------------------------------------------
vim.g.mapleader = " " -- Set leader key.
vim.g.maplocalleader = "," -- Set default local leader key.
vim.g.big_file = { size = 1024 * 5000, lines = 50000 } -- For files bigger than this, disable 'treesitter' (+5Mb).

-- The next globals are toggleable with <space + l + u>
vim.g.autoformat_enabled = false -- Enable auto formatting at start.
vim.g.autopairs_enabled = false -- Enable autopairs at start.
vim.g.cmp_enabled = true -- Enable completion at start.
vim.g.codeactions_enabled = true -- Enable displaying 💡 where code actions can be used.
vim.g.codelens_enabled = true -- Enable automatic codelens refreshing for lsp that support it.
vim.g.diagnostics_mode = 3 -- Set code linting (0=off, 1=only show in status line, 2=virtual text off, 3=all on).
vim.g.fallback_icons_enabled = false -- Enable it if you need to use Neovim in a machine without nerd fonts.
vim.g.inlay_hints_enabled = false -- Enable always show function parameter names.
vim.g.lsp_round_borders_enabled = true -- Enable round borders for lsp hover and signatureHelp.
vim.g.lsp_signature_enabled = true -- Enable automatically showing lsp help as you write function parameters.
vim.g.notifications_enabled = true -- Enable notifications.
vim.g.semantic_tokens_enabled = true -- Enable lsp semantic tokens at start.
vim.g.url_effect_enabled = true -- Highlight URLs with an underline effect.
