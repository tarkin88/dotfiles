return {
  "zeioth/compiler.nvim",
  cmd = {
    "CompilerOpen",
    "CompilerToggleResults",
    "CompilerRedo",
    "CompilerStop",
  },
  dependencies = {
    "stevearc/overseer.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>r", "", desc = "+runner" },
    { "<leader>ro", "<cmd>CompilerOpen<cr>", desc = "Open Compiler menu" },
    { "<leader>rs", "<cmd>CompilerStop<cr> <cmd>CompilerRedo<cr>", desc = "Stop Compiler" },
    { "<leader>rt", "<cmd>CompilerToggleResults<cr>", desc = "Toggle Compiler menu" },
  },
}
