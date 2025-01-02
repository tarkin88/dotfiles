return {
  "loctvl842/monokai-pro.nvim",
  event = "UIEnter",
  opts = {
    styles = {
      comment = { italic = true },
      keyword = { italic = true }, -- any other keyword
      type = { italic = true }, -- (preferred) int, long, char, etc
      storageclass = { italic = true }, -- static, register, volatile, etc
      structure = { italic = true }, -- struct, union, enum, etc
      parameter = { italic = true }, -- parameter pass in function
      annotation = { italic = true },
      tag_attribute = { italic = true }, -- attribute of tag in reactjs
    },
    filter = "pro",
  },
  config = function(_, opts)
    require("monokai-pro").setup(opts)

    vim.cmd([[colorscheme monokai-pro]])
  end,
}
