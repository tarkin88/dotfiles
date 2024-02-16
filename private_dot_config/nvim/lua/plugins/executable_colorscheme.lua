return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    background = "soft",
    transparent_background_level = 0,
    italics = true,
    disable_italic_comments = false,
    on_highlights = function(hl, _)
      hl["@symbol"] = { link = "@field" }
    end,
  },
  config = function(_, opts)
    local theme = require("everforest")
    theme.setup(opts)
    theme.load()
  end,
}
