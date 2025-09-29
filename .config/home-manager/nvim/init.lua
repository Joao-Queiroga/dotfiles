if vim.env.PROF then
  -- vim.cmd.packadd('snacks.nvim')
  require("snacks.profiler").startup({
    startup = {
      event = "UIEnter",
    },
  })
end
vim.loader.enable()

vim.cmd.colorscheme('tokyonight-night')
require('config.options')
require('config.keybindings')
require('plugins')
vim.lsp.enable({ 'lua_ls', 'nil_ls' })
