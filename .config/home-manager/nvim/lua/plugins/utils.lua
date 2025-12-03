---@type PluginList
return {
  {
    "vim-tmux-navigator",
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "vim-startuptime",
    cmd = "StartupTime",
    before = function()
      vim.g.startuptime_event_width = 0
      vim.g.startuptime_tries = 10
      vim.g.startuptime_exe_path = require("nixCats").packageBinPath
    end,
  },
  {
    "vim-table-mode",
    cmd = {
      "TableModeToggle",
      "TableModeEnable",
    },
    keys = {
      { "<leader>t", desc = "Table Mode" },
      { "<leader>tm", desc = "Toggle" },
      { "<leader>tt", desc = "Tableize" },
      { "<leader>tr", desc = "Realign" },
      { "<leader>ts", desc = "Sort" },
      { "<leader>ti", "", desc = "Insert Column" },
      { "<leader>tic", desc = "After" },
      { "<leader>tiC", desc = "Before" },
      { "<leader>td", "", desc = "Delete" },
      { "<leader>tdr", desc = "Row" },
      { "<leader>tdc", desc = "Column" },
      { "<leader>tf", "", desc = "Formula" },
      { "<leader>tfa", desc = "Add" },
      { "<leader>tfe", desc = "Eval" },
    },
    before = function()
      vim.g.table_mode_corner = "|"
      vim.g.table_mode_header = "-"
      vim.g.table_mode_hl_cells = 1
    end,
  },
}
