return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  lazy = false,
  config = function()
    local alpha = require "alpha"
    local startify = require "alpha.themes.startify"
    local opts = {
      layout = {
        {
          type = "text",
          val = {
            [[                                  __                 ]],
            [[     ___     ___    ___   __  __ /\_\    ___ ___     ]],
            [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\   ]],
            [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \  ]],
            [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\ ]],
            [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/ ]],
          },
          opts = {
            hl = "Type",
            shrink_margin = false,
          },
        },
        { type = "padding", val = 3 },

        startify.section.mru_cwd,
        startify.section.mru,
        { type = "padding", val = 3 },
        {
          type = "text",
          val = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      },
      opts = {
        margin = 5,
      },
    }
    alpha.setup(opts)
  end,
}
