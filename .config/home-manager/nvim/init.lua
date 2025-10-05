if vim.env.PROF then
  vim.cmd.packadd("snacks.nvim")
  require("snacks.profiler").startup({
    startup = {
      event = "UIEnter",
    },
  })
end
vim.loader.enable()

vim.cmd.colorscheme("tokyonight-night")
require("config.options")
require("config.lsp")
require("config.keybindings")
require("config.autocmd")
require("plugins")
