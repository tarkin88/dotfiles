local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local opts = { silent = true, noremap = true }

-- NORMAL
map("n", "<C-s>", "<cmd>w<cr>", {desc = "save" , noremap = true})
map("n", "<C-q>", "<cmd>confirm q<CR>", {desc = "quit" , noremap = true})
map("n", "<Esc>", "<cmd>nohlsearch<cr>", {desc = "remove highlight from search" , noremap = true})
map("n", "<leader>z", "<CMD>set invrnu invnu<CR>", {desc= "show/unshow Relative line Numbers" ,noremap = true})
map("n", "<leader>|", "<C-w>v", {desc = "vertical split" , noremap = true})
map("n", "<leader>_", "<C-w>s", {desc = "horizontal split" , noremap = true})
map("n", "<Tab>", "<Tab>", {
  noremap = true,
  silent = true,
  expr = false,
  desc = "FIX: Prevent TAB from behaving like <C-i>, as they share the same internal code"})
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "<A-Right>", "<cmd>bprevious<cr>", opts)
map("n", "<A-Left>", "<cmd>bnext<cr>", opts)
map("n", "<leader>t", "<cmd>botright new | resize 14 | terminal<cr>", {desc = "vscode like terminal", noremap =  true})
-- VISUAL
map("v", "<C-c>", '"+y', {desc = "Copy yank to clipboard", noremap =  true})
map("v", "p", '"_dP', {desc =  "better paste", noremap=true})
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

