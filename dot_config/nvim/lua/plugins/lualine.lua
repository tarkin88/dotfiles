return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    sections = {
      lualine_c = {
        {
          function() return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or "" end,
          padding = { right = 1, left = 1 },
          separator = { left = "", right = "" },
        },
        "branch",
        "diff",
        "diagnostics",
      },
      lualine_x = { "overseer" },
    },
  },
  config = function(_, opts) require("lualine").setup(opts) end,
}
