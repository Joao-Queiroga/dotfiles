local install_servers = {
  "lua_ls",
  "rust_analyzer",
  "clangd",
  "gopls",
  "jdtls",
  "emmet_language_server",
  "ts_ls",
  "cssls",
  "jsonls",
  "yamlls",
}
vim.lsp.enable({ "qmlls" })
---@type LazySpec[]
return {
  {
    "neovim/nvim-lspconfig",
    keys = { { "<leader>l", "", desc = "LSP", mode = { "n", "v", "x" } } },
    dependencies = {
      "folke/neoconf.nvim",
    },
    lazy = true,
    init = function()
      local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
      vim.opt.runtimepath:prepend(lspConfigPath)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "folke/neoconf.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = install_servers,
      automatic_enable = {
        exclude = {
          "rust_analyzer",
          "ts_ls",
          "jdtls",
        },
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    "folke/neoconf.nvim",
    lazy = false,
    priority = 1,
    opts = {},
  },
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>ld",
        "<cmd>Trouble diagnostics toggle<cr>",
        mode = { "n", "v", "x" },
        desc = "Document Diagnostics",
      },
      { "<leader>lq", "<cmd>Trouble quickfix toggle<cr>", mode = { "n", "v", "x" }, desc = "Quickfixes" },
      { "<leader>ll", "<cmd>Trouble loclist toggle<cr>", mode = { "n", "v", "x" }, desc = "Loclist" },
      {
        "<leader>lR",
        "<cmd>Trouble lsp_references toggle<cr>",
        mode = { "n", "v", "x" },
        desc = "LSP References",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {},
  },
  { import = "plugins.lsp.language-specifics" },
}
