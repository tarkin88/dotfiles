return {
  "amitds1997/remote-nvim.nvim",
  version = "*", -- Pin to GitHub releases
  cmd = "RemoteStart",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "stevearc/dressing.nvim",
  },
  keys = {
    { "<F9>", "<cmd>RemoteStart<cr>", { desc = "Start remote" } },
  },

  opts = {
    devpod = {
      container_list = "all",
    },
    client_callback = function(port, workspace_config)
      for key, value in pairs(workspace_config) do
        print(key, "=", value)
      end
      if vim.env.TERM == "st-256color" then cmd = ("st -e nvim --server localhost:%s --remote-ui"):format(port) end
      vim.fn.jobstart(cmd, {
        detach = true,
        on_exit = function(job_id, exit_code, event_type)
          vim.notify(("Local client failed with exit code %s"):format(exit_code), vim.log.levels.ERROR)
        end,
      })
    end,
  },
  config = function(_, opts)
    local remote = require "remote-nvim"
    remote.setup(opts)
  end,
}
