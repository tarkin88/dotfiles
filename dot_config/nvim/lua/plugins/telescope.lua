return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function() return vim.fn.executable("make") == 1 end,
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        prompt_prefix = "",
        selection_caret = "  ",
        scroll_strategy = "limit",
        borderchars = {
          "─",
          "│",
          "─",
          "│",
          "╭",
          "╮",
          "╯",
          "╰",
        },
        path_display = { shorten = 9 },
        mappings = {
          i = {},
          n = {},
        },

        -- ignore file that is not supposed to be found through telescope
        file_ignore_patterns = {
          ".git/",
          "%.bin",
          "%.cmake",
          "%.check_cache",
          "%.dir",
          "%.docx",
          "%.gif",
          "%.jpg",
          "%.jpeg",
          "%.json",
          "%.key",
          "%.make",
          "%.marks",
          "%.md",
          "%.o",
          "%.out",
          "%.pdf",
          "%.png",
          "%.pptx",
          "%.pth",
          "%.pyc",
          "%.so",
          "%.vtu",
          "%.wav",
          "%.xlsx",
        },
      },

      pickers = {
        live_grep = {
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        grep_string = {
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        find_files = {
          theme = "dropdown",
          previewer = true,
          -- hidden = true,
          find_command = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--files",
            "--hidden",
            "-g",
            "!.git",
          },
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        oldfiles = {
          theme = "dropdown",
          previewer = false,
          hidden = true,
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        git_status = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
        },
        lsp_document_symbols = {
          theme = "dropdown",
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    -- use protected call to attempt to load telescope
    local success, telescope = pcall(require, "telescope")
    if not success then
      vim.notify("Failed to load plugin: telescope")
      return
    end

    telescope.setup(opts)

    -- enable telescope extensions if they are installed
    success, _ = pcall(require("telescope").load_extension, "fzf")
    if not success then
      vim.notify("Failed to load telescope extension fzf")
      return
    end
  end,
  keys = {
    { "<leader>f", "", desc = "+search" },
    {
      "<C-p>",
      function() require("telescope.builtin").find_files() end,
      desc = "find files",
    },
    {
      "<leader>ff",
      function() require("telescope.builtin").find_files() end,
      desc = "find files",
    },
    {
      "<leader>fo",
      function() require("telescope.builtin").oldfiles() end,
      desc = "recent files",
    },
    {
      "<leader>fd",
      function() require("telescope.builtin").diagnostics() end,
      desc = "diagnostics",
    },
    {
      "<leader>fw",
      function() require("telescope.builtin").current_buffer_fuzzy_find() end,
      desc = "fuzzy word",
    },
    {
      "<leader>fs",
      function() require("telescope.builtin").live_grep() end,
      desc = "live grep",
    },
    {
      "<leader>fg",
      function() require("telescope.builtin").grep_string() end,
      desc = "grep",
    },
    {
      "<leader>ls",
      function() require("telescope.builtin").lsp_document_symbols() end,
      desc = "lsp_document_symbols",
    },
    {
      "<F5>",
      function() require("telescope.builtin").lsp_document_symbols() end,
      desc = "lsp_document_symbols",
    },
    {
      "<M-Up>",
      function() require("telescope.builtin").buffers() end,
      desc = "buffers",
    },
  },
}
