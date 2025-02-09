---@type LazySpec[]
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
      },
      {
        "<leader>gf",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
      {
        "<leader>gl",
        function()
          Snacks.lazygit.log()
        end,
        desc = "Lazygit Log (cwd)",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>yl",
        function()
          local original_env = {
            GIT_DIR = vim.env.GIT_DIR,
            WORK_TREE = vim.env.WORK_TREE,
          }
          vim.env.GIT_DIR = vim.fn.expand("~/.local/share/chezmoi/.git")
          vim.env.WORK_TREE = vim.fn.expand("~/.local/share/chezmoi")
          Snacks.lazygit()
          vim.env.GIT_DIR = original_env.GIT_DIR
          vim.env.WORK_TREE = original_env.WORK_TREE
        end,
        desc = "Lazygit",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "󰐊" },
        topdelete = { text = "󰐊" },
        changedelete = { text = "▎" },
      },
    },
  },
}
