vim.lsp.enable({ "lua_ls", "nil_ls", "gopls", "emmet_language_server", "cssls", "jsonls", "yamlls" })
---@type lze.PluginSpec[]
return {
  {
    "nvim-lspconfig",
    lazy = true,
    beforeAll = function()
      local lspConfigPath = require("nixCats").vimPackDir .. "/pack/myNeovimPackages/opt/nvim-lspconfig/"
      vim.opt.runtimepath:prepend(lspConfigPath)
    end,
  },
  {
    "vim-illuminate",
    event = "DeferredUIEnter",
    config = function()
      require("illuminate").configure()
    end,
  },
  {
    "trouble.nvim",
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
    cmd = "Trouble",
    after = function()
      require("trouble").setup()
    end,
  },
  { import = "plugins.lsp.language-specific" },
}
