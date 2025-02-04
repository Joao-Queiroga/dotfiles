---@type LazySpec[]
return {
  {
    "echasnovski/mini.files",
    keys = {
      { "<leader>fm", "<cmd>lua MiniFiles.open()<cr>", desc = "File Browser", mode = { "n", "v" } },
    },
    lazy = false,
    opts = {
      windows = {
        preview = true,
        width_preview = 40,
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    keys = {
      {
        "<leader>fM",
        function()
          require("yazi").yazi()
        end,
        desc = "Open the file manager",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
    },
  },
}
