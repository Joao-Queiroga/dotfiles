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
            GIT_WORK_TREE = vim.env.GIT_WORK_TREE,
          }
          vim.env.GIT_DIR = vim.fn.expand("$HOME/.local/share/yadm/repo.git")
          vim.env.GIT_WORK_TREE = vim.fn.expand("$HOME")
          Snacks.lazygit()
          vim.env.GIT_DIR = original_env.GIT_DIR
          vim.env.GIT_WORK_TREE = original_env.GIT_WORK_TREE
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
  {
    "purarue/gitsigns-yadm.nvim",
    lazy = true,
    dependencies = {
      {
        "lewis6991/gitsigns.nvim",
        opts = {
          _on_attach_pre = function(bufnr, callback)
            require("gitsigns-yadm").yadm_signs(callback, { bufnr = bufnr })
          end,
        },
      },
    },
    opts = {
      shell_timeout_ms = 1000,
    },
  },
}
