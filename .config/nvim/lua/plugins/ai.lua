---@type LazySpec[]
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {},
  },
  {
    "monkoose/neocodeium",
    cmd = "Neocodium",
    keys = {
      {
        "<c-g>",
        function()
          return require("neocodeium").accept()
        end,
        mode = "i",
        expr = true,
      },
      {
        "<c-;>",
        function()
          return require("neocodeium").cycle_or_complete(1)
        end,
        mode = "i",
        expr = true,
      },
      {
        "<c-,>",
        function()
          return require("neocodeium").cycle(-1)
        end,
        mode = "i",
        expr = true,
      },
      {
        "<c-x>",
        function()
          return require("neocodeium").clear()
        end,
        mode = "i",
        expr = true,
      },
    },
    opts = {
      manual = true,
    },
  },
}
