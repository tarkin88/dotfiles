return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    size = 20,
    hide_numbers = true,
    open_mapping = [[<F7>]],
    shading_factor = 0.3,
    direction = "float",
    float_opts = {
      border = "curved",
      highlights = { border = "Normal", background = "Normal" },
    },
    shade_filetypes = {},
    shade_terminals = false,
    start_in_insert = true,
    persist_size = true,
    winbar = {
      enabled = false,
      name_formatter = function(term) return term.name end,
    },
  },
  keys = {
    { "<F7>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}
