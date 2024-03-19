return {
  "rose-pine/neovim",
  name = "rose-pine",
  version = false,
  lazy = false,
  priority = 1000,
  opts = {
    variant = "moon",
    dark_variant = "moon",
  },
  config = function(_, opts)
    local theme = require("rose-pine")

    theme.setup(opts)
    vim.cmd("colorscheme rose-pine-moon")
    -- theme.load()
  end,
}
