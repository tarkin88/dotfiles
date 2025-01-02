return {
  {
    "echasnovski/mini.files",
    version = false,
    cmd = "MiniFiles",
    opts = {
      mappings = {
        close = "<Escape>",
        go_in_plus = "<CR>",
      },
    },
    config = true,
    keys = {
      { "<leader>e", "", desc = "+files", mode = { "n", "v" } },
      { "<leader>ef", "<cmd>lua MiniFiles.open(MiniFiles.get_latest_path())<cr>", desc = "open mini files" },
      {
        "<leader>ee",
        "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
        desc = "open mini files in current path",
      },
    },
  },
  { "echasnovski/mini.tabline", version = false, event = "BufEnter", config = true },
  { "echasnovski/mini.statusline", version = false, event = "BufEnter", config = true },
  { "echasnovski/mini.surround", version = false, event = "InsertEnter", config = true },
  { "echasnovski/mini.comment", version = false, event = "InsertEnter", config = true },
  { "echasnovski/mini.cursorword", version = false, event = "InsertEnter", config = true },
  { "echasnovski/mini.pairs", version = false, event = "InsertEnter", config = true },
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "BufEnter",
    opts = {
      draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 300,
      },
      options = { border = "top", try_as_border = true },
      symbol = "│",
    },
    config = function(_, opts)
      require("mini.indentscope").setup(opts)

      vim.api.nvim_create_autocmd({ "FileType" }, {
        desc = "Disable indentscope for certain filetypes",
        callback = function()
          local ignored_filetypes = {
            "alpha",
            "help",
            "lazy",
            "mason",
            "notify",
            "calltree",
          }
          if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then vim.b.miniindentscope_disable = true end
        end,
      })
    end,
  },
  {
    "echasnovski/mini.clue",
    version = false,
    event = "VimEnter",
    opts = function()
      local miniclue = require("mini.clue")
      local opts = {
        window = {
          delay = 500,
          config = {
            width = 70,
          },
        },
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows({ submode_resize = true }),
          miniclue.gen_clues.z(),
        },
      }
      return opts
    end,
    config = true,
  },
  {
    "echasnovski/mini.animate",
    version = false,
    event = "VimEnter",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")

      return {
        open = { enable = false }, -- true causes issues on nvim-spectre
        resize = {
          timing = animate.gen_timing.linear({ duration = 33, unit = "total" }),
        },
        cursor = {
          enable = false, -- We don't want cursor ghosting
          timing = animate.gen_timing.linear({ duration = 26, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
  },

  {
    "echasnovski/mini.icons",
    version = false,
    event = "VimEnter",
    config = function()
      local icons = require("mini.icons")
      icons.setup()
      icons.tweak_lsp_kind()
    end,
  },
  {
    "echasnovski/mini.bufremove",
    version = false,
    event = "VimEnter",
    keys = {
      { "<M-Down>", "<cmd>lua require('mini.bufremove').delete()<cr>", desc = "remove buffer" },
    },
    config = true,
  },
  {
    "echasnovski/mini.notify",
    version = false,
    event = "VimEnter",
    config = function(_, opts)
      require("mini.notify").setup(opts)
      vim.notify = require("mini.notify").make_notify()
    end,
  },
}
