local function setup_colors()
  local utils = require("heirline.utils")
  return {
    bg_highlight = utils.get_highlight("CursorLine").bg or "#000000",
    bg = utils.get_highlight("StatusLine").bg or "#000000",
    fg_bright = utils.get_highlight("Folded").fg or "#FFFFFF",
    red = utils.get_highlight("DiagnosticError").fg or "#FF0000",
    dark_red = utils.get_highlight("DiffDelete").bg or "#8B0000",
    green = utils.get_highlight("String").fg or "#008000",
    blue = utils.get_highlight("Function").fg or "#0000FF",
    gray = utils.get_highlight("NonText").fg or "#808080",
    orange = utils.get_highlight("Constant").fg or "#FFA500",
    purple = utils.get_highlight("@keyword").fg or "#800080",
    magenta = utils.get_highlight("Statement").fg or "#FF00FF",
    cyan = utils.get_highlight("Keyword").fg or "#00FFFF",
    git_del = utils.get_highlight("diffRemoved").fg or "#FF0000",
    git_add = utils.get_highlight("diffAdded").fg or "#008000",
    git_change = utils.get_highlight("diffChanged").fg or "#0000FF",
  }
end
---@type PluginList
return {
  {
    "heirline.nvim",
    event = "DeferredUIEnter",
    before = function()
      vim.api.nvim_create_augroup("Heirline", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          require("heirline.utils").on_colorscheme(setup_colors)
        end,
        group = "Heirline",
      })
    end,
    after = function()
      require("heirline").setup({
        statusline = require("plugins.heirline.statusline"),
        tabline = require("plugins.heirline.tabline"),
        opts = {
          colors = setup_colors,
          disable_winbar_cb = function(args)
            return require("heirline.conditions").buffer_matches({
              buftype = { "nofile", "prompt", "help", "quickfix" },
              filetype = {
                "^git.*",
                "snacks_terminal",
                "help",
                "startify",
                "dashboard",
                "neogitstatus",
                "NvimTree",
                "yazi",
                "Trouble",
                "alpha",
                "spectre_panel",
                "toggleterm",
                "neo-tree",
                "neo-tree-popup",
                "notify",
                "lazygit",
              },
            }, args.buf)
          end,
        },
      })
    end,
  },
}
