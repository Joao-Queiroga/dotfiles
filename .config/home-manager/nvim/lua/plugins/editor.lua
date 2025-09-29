---@type lze.PluginSpec[]
return {
  {
    "ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    after = function()
      require('ultimate-autopair').setup()
    end
  }
}
