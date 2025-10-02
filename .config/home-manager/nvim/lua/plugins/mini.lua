---@type lze.PluginSpec[]
return {
  {
    "mini.nvim",
    lazy = false,
    keys = {
      { "<leader>c", function()
        require('mini.bufremove').delete()
      end }
    },
    beforeAll = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    after = function()
      require('mini.align').setup({
        mappings = {
          start_with_preview = "ga",
          start = "gA",
        },
      })
      require('mini.move').setup()
    end
  },
}
