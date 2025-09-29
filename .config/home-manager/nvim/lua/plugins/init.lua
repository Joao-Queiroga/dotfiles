require("lze").load({
  {
    "vim-tmux-navigator",
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.editor" },
  { import = "plugins.formating" },
  { import = "plugins.lint" },
  { import = "plugins.utils" },
  { import = "plugins.ui" },
  { import = "plugins.mini" },
})
