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
