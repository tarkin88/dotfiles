return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  opts = function()
    local actions = require "telescope.actions"
    local icons = require "core.icons"
    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = icons.ui.Forward .. " ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        path_display = { shorten = 7 },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          hidden = true,
          find_command = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--files",
            "--hidden", "-g", "!.git"
          },
        },
        oldfiles = {
          theme = "dropdown",
          previewer = false,
          hidden = true,
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
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)
    telescope.load_extension "fzf"
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<C-p>",      "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",    desc = "Old files" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Search and string" },
    { "<leader>fS", "<cmd>Telescope live_grep<cr>",   desc = "Live serch" },
    { "<A-Up>",     "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
  },
}
