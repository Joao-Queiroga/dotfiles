---@type LazySpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = function()
      require("nvim-treesitter").install("all")
      require("nvim-treesitter").update()
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
}
