---@type LazySpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile", "VeryLazy" },
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    opts = {
      ensure_installed = "all",
      ignore_install = { "org" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" },
      },
      indent = {
        enable = true,
      },
    },
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
