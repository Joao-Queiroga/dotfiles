---@type PluginList
return {
  {
    "rainbow-delimiters.nvim",
    event = "BufRead",
  },
  {
    "nvim-ts-autotag",
    event = "InsertEnter",
    after = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close_on_slash = true,
        },
      })
    end,
  },
  {
    "nvim-ts-context-commentstring",
    event = "BufRead",
    after = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
}
