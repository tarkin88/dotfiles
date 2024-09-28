return {
  "folke/which-key.nvim",
  opts = {
    defaults = {},
    spec = {
      { "<BS>", desc = "Decrement Selection", mode = "x" },
      { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
      { "<leader>r", group = "remote" },
      { "<leader>p", group = "python" },
      { "<leader>f", group = "telescope" },
      { "<leader>t", group = "terminal" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>u", group = "ui" },
      { "g", group = "goto" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show { global = false } end,
      desc = "Buffer Keymaps (which-key)",
    },
  },
  config = true,
}
