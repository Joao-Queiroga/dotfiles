---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {},
  keys = {
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
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
        vim.env.GIT_DIR = vim.fn.expand("~/.local/share/yadm/repo.git")
        vim.env.WORK_TREE = os.getenv("HOME")
        Snacks.lazygit()
        vim.env.GIT_DIR = original_env.GIT_DIR
        vim.env.WORK_TREE = original_env.WORK_TREE
      end,
      desc = "Lazygit",
    },
    {
      "<c-t>",
      function()
        Snacks.terminal()
      end,
      mode = { "i", "n", "t" },
      desc = "Toggle Terminal",
    },
    {
      "<leader>fn",
      function()
        Snacks.rename()
      end,
      desc = "Rename File",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd
      end,
    })
  end,
}
