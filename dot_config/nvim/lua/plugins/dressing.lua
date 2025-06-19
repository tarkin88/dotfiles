return {
  'stevearc/dressing.nvim',
  event = "VeryLazy",
  opts = {
        input = {
        -- Default options for input UI
        enabled = true,
        default_prompt = "➤ ",
        prompt_align = "left",
        insert_only = true,
        start_in_insert = true,
        relative = "editor",
        prefer_width = 60,
        width = nil,
        max_width = nil,
        min_width = 20,
        border = "rounded",
        anchor = "NW",
        pos = "100%",
        row = 1,
        col = 1,
      },
      select = {
        -- Default options for select UI
        enabled = true,
        backend = { "builtin" },
        builtin = {
          border =  "rounded",
          anchor = "NW",
          post = "100%",
        },
      },
},
}
