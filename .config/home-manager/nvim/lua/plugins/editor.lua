---@type PluginList
return {
  {
    "ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    after = function()
      require("ultimate-autopair").setup()
    end,
  },
  {
    "project.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("project").setup({})
    end,
  },
}
