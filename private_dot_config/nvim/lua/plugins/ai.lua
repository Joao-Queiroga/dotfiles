---@type LazySpec[]
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
}
