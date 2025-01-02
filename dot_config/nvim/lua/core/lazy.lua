--- Download 'lazy' from its git repository if lazy_dir doesn't exists already.
--- Note: This function should ONLY run the first time you start nvim.
--- @param lazy_dir string Path to clone lazy into. Recommended: `<nvim data dir>/lazy/lazy.nvim`
local function git_clone_lazy(lazy_dir)
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_dir,
  })
  if vim.api.nvim_get_vvar("shell_error") ~= 0 then
    vim.api.nvim_err_writeln("Error cloning lazy.nvim repository...\n\n" .. output)
  end
end

--- This functions creates a one time autocmd to load the plugins passed.
--- This is useful for plugins that will trigger their own update mechanism when loaded.
---
--- Note: This function should ONLY run the first time you start nvim.
--- @param plugins string[] plugins to load right after lazy end installing all.
local function after_installing_plugins_load(plugins)
  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyInstall",
    once = true,
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module) pcall(require, module) end, plugins)
      -- Note: Loading mason and treesitter will trigger updates there too if necessary.
    end,
    desc = "Load Mason and Treesitter after Lazy installs plugins",
  })
end

--- Require lazy and pass the spec.
--- @param lazy_dir string used to specify neovim where to find the lazy_dir.
local function setup_lazy(lazy_dir)
  local spec = { import = "plugins" }

  vim.opt.rtp:prepend(lazy_dir)
  require("lazy").setup({
    spec = spec,
    install = { enabled = true },
    checker = { enabled = true },
    defaults = { lazy = true },
    performance = {
      rtp = { -- Disable unnecessary nvim features to speed up startup.
        disabled_plugins = {
          "tohtml",
          "gzip",
          "zipPlugin",
          "netrwPlugin",
          "tarPlugin",
          "vimball",
          "netrwSettings",
          "netrwFileHandlers",
          "rrhelper",
          "logiPat",
          "matchit",
          -- "matchparen",
          "tar",
          "tutor",
          "zip",
        },
      },
    },
    -- Enable luarocks if installed.
    rocks = { enabled = vim.fn.executable("luarocks") == 1 },
    change_detection = {
      enabled = false,
    },
  })
end

local lazy_dir = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local is_first_startup = not vim.uv.fs_stat(lazy_dir)

-- Call the functions defined above.
if is_first_startup then
  git_clone_lazy(lazy_dir)
  after_installing_plugins_load({ "nvim-treesitter", "mason" })
  vim.notify("Please wait while plugins are installed...")
end
setup_lazy(lazy_dir)
