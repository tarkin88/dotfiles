return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "moon",
  },
  config = function(_, opts)
    local theme = require "rose-pine"
    theme.setup(opts)
    vim.cmd "colorscheme rose-pine"
  end,
}
