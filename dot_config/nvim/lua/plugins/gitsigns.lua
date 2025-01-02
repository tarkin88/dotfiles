return {
  "lewis6991/gitsigns.nvim",
  config = true,
  event = "BufEnter",
  keys = {
    { "<leader>g", "", desc = "+git" },
    { "<leader>gg", "<cmd>Gitsigns<cr>", desc = "action list" },
    { "<leader>gl", "<cmd>Gitsigns blame_line<cr>", desc = "blame line" },
    { "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "blame file" },
  },
}
