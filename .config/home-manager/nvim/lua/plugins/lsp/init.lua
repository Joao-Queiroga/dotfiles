return {
  {
    'nvim-lspconfig',
    lazy = true,
    beforeAll = function()
      local lspConfigPath = require('nixCats').vimPackDir .. '/pack/myNeovimPackages/opt/nvim-lspconfig/'
      vim.opt.runtimepath:prepend(lspConfigPath)
    end,
  },
  {
    "lazydev.nvim",
    ft = "lua",
    after = function()
      require('lazydev').setup()
    end,
    on_require = { "lazydev" }
  }
}
