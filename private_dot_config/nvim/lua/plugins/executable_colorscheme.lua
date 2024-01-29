return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  opts = {

  },
  config = function(_, opts)
    local theme = require("rose-pine")
    theme.setup(opts)
    -- theme.load()
    vim.cmd('colorscheme rose-pine-moon')
  end,
}
