return {
  "windwp/nvim-spectre",
  -- stylua: ignore
  keys = {
    { "<leader>sR", function() require("spectre").open() end,                          desc = "Replace in Files (Spectre)" },
    { "<leader>sr", function() require("spectre").open_visual({ select_word = true }) end, desc = "Replace current word in Files (Spectre)" },
  },
}
