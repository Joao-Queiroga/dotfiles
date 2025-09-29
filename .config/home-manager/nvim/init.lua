if vim.env.PROF then
  require("snacks.profiler").startup({
    startup = {
      -- event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      event = "UIEnter",
    },
  })
end

vim.loader.enable()
vim.cmd.colorscheme('tokyonight-night')
require('config.options')
require('config.keybindings')
require('plugins')
vim.lsp.enable('lua_ls')
