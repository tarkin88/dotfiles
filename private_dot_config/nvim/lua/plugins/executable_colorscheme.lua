return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    flavour = "frappe",
    no_italic = false,         -- Force no italic
    no_bold = false,           -- Force no bold
    no_underline = false,      -- Force no underline
    styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = { "bold" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = { "italic" },
      operators = { "bold" },
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
    custom_highlights = function(colors)
      return {
        Comment = { fg = colors.flamingo },
        TabLineSel = { bg = colors.pink },
        CmpBorder = { fg = colors.surface2 },
        Pmenu = { bg = colors.none },
      }
    end
  },
  config = function(_, opts)
    local theme = require("catppuccin")
    theme.setup(opts)
    theme.load()
  end,
}
