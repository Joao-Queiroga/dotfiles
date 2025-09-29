return {
  {
    "vim-startuptime",
    cmd = "StartupTime",
    before = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
