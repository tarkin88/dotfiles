return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  opts = {
    background = "soft",
    italics = true,
    on_highlights = function(hl, palette)
      hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
      hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
      hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
      hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
    end,
  },
  config = function(_, opts)
    local theme = require("everforest")
    theme.setup(opts)
    theme.load()
  end,
}
