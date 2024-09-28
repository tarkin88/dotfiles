local map = vim.keymap.set

local opts = { silent = true, noremap = true }

-- NORMAL
-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save", noremap = true, silent = true })
map("n", "<C-q>", "<cmd>q<CR>", opts)
map("n", "<ESC>", [[<C-\><C-n>]], opts)
-- Clear highlights
map("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)
-- buffer navigation
map("n", "<A-Right>", "<cmd>bn<cr>", opts)
map("n", "<A-Left>", "<cmd>bp<cr>", opts)
-- Better Redo Option
map("n", "U", "<C-r>", opts)
-- For not yanking when deleting chars
map("n", "x", '"_x', opts)
-- Show/Unshow Relative line Numbers
map("n", "<leader>z", "<CMD>set invrnu invnu<CR>", opts)
-- For Easier Splitting of buffer
map("n", "<leader>|", "<C-w>v", { desc = "split in vertical", silent = true, noremap = true })
map("n", "<leader>_", "<C-w>s", { desc = "split in horizontal", silent = true, noremap = true })

-- VISUAL
-- copy yank
map("v", "<C-c>", '"+y', opts)
-- Better paste
map("v", "p", '"_dP', opts)
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- terminal
map("n", "<leader>to", "<cmd>terminal<cr>", { desc = "open a terminal", noremap = true })

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")
