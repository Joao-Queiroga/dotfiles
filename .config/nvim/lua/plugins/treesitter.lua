---@type LazySpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
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
