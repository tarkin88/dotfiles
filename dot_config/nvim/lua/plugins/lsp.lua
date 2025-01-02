local lang_servers = {
  "lua_ls",
  "pyright",
  "jsonls",
  "bashls",
  "yamlls",
}
local lint_and_formarters = {
  "stylua",
  "black",
  "isort",
  "debugpy",
  "shfmt",
  "shellcheck",
  "pylint",
  "codespell",
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
    },
    opts = {
      ensure_installed = lint_and_formarters,
      ui = {
        border = "none",
        icons = {
          package_installed = "i",
          package_pending = "p",
          package_uninstalled = "u",
        },
      },
    },
    config = function(_, opts)
      local mason = require("mason")
      local mr = require("mason-registry")
      mason.setup(opts)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
            vim.notify("Installing " .. tool)
          end
        end
      end)
    end,
  },
  --
  -- -- Autocompletion
  -- {
  --   -- "hrsh7th/nvim-cmp",
  --   "yioneko/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-nvim-lsp-signature-help",
  --     {
  --       "L3MON4D3/LuaSnip",
  --       dependencies = { "rafamadriz/friendly-snippets" },
  --       opts = {
  --         history = true,
  --         delete_check_events = "TextChanged",
  --         region_check_events = "CursorMoved",
  --       },
  --     },
  --     "saadparwaiz1/cmp_luasnip",
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --     vim.tbl_map(
  --       function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
  --       { "vscode", "snipmate", "lua" }
  --     )
  --     -- friendly-snippets - enable standardized comments snippets
  --     require("luasnip").filetype_extend("lua", { "luadoc" })
  --     require("luasnip").filetype_extend("python", { "pydoc" })
  --     require("luasnip").filetype_extend("sh", { "shelldoc" })
  --
  --     cmp.setup({
  --       sources = {
  --         { name = "path" },
  --         { name = "nvim_lsp" },
  --         { name = "nvim_lsp_signature_help" },
  --         { name = "luasnip", option = { show_autosnippets = true }, keyword_length = 2 },
  --         { name = "buffer", keyword_length = 3 },
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       snippet = {
  --         expand = function(args) require("luasnip").lsp_expand(args.body) end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<CR>"] = cmp.mapping({
  --           i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
  --           c = function(fallback)
  --             if cmp.visible() then
  --               cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  --             else
  --               fallback()
  --             end
  --           end,
  --         }),
  --         -- Jump to the next snippet placeholder
  --         ["<C-k>"] = cmp.mapping(function(fallback)
  --           local luasnip = require("luasnip")
  --           if luasnip.locally_jumpable(1) then
  --             luasnip.jump(1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         -- Jump to the previous snippet placeholder
  --         ["<C-j>"] = cmp.mapping(function(fallback)
  --           local luasnip = require("luasnip")
  --           if luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-d>"] = cmp.mapping.scroll_docs(4),
  --       }),
  --     })
  --   end,
  -- },
  --
  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- { "hrsh7th/cmp-nvim-lsp" },
      "saghen/blink.cmp",
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function(_, opts)
      local lsp_defaults = require("lspconfig").util.default_config
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
          },
        },
      })

      local lspconfig = require("lspconfig")

      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())
      -- for server, config in pairs(opts.servers) do
      --   -- passing config.capabilities to blink.cmp merges with the capabilities in your
      --   -- `opts[server].capabilities, if you've defined it
      --   config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      --   lspconfig[server].setup(config)
      -- end

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      -- lsp_defaults.capabilities =
      --   vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
          -- get client info
          local id = vim.tbl_get(event, "data", "client_id")
          local client = id and vim.lsp.get_client_by_id(id)
          if client == nil then return end

          -- Disable semantic highlights
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = lang_servers,
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name) require("lspconfig")[server_name].setup({}) end,
        },
      })
    end,
  },
}
