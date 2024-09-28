return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "stylua",
          "black",
          "isort",
          "debugpy",
          "shfmt",
          "pylint",
        },
      },
      config = function(_, opts)
        require("mason").setup(opts)
        local mr = require "mason-registry"

        mr.refresh(function()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then p:install() end
          end
        end)
      end,
    },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ui = {
      border = "none",
    },
    servers = {
      "diagnosticls",
      "typos_lsp",
      "bashls",
      "jsonls",
      "lua_ls",
      "marksman",
      "pyright",
    },
    border = {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts.ui)
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = opts.border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = opts.border }),
    }

    require("mason-lspconfig").setup {
      ensure_installed = opts.servers,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            handlers = handlers,
          }
        end,
      },
    }
  end,
}
