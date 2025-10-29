---@type PluginList
return {
  {
    "blink.cmp",
    lazy = false,
    after = function()
      require("blink.cmp").setup({
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
        keymap = {
          preset = "enter",
          ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<C-E>"] = { "hide_documentation", "fallback" },
          ["<C-j>"] = { "scroll_documentation_down", "fallback" },
          ["<C-k>"] = { "scroll_documentation_up", "fallback" },
        },
        appearance = {
          nerd_font_variant = "normal",
          kind_icons = vim.g.kind_icons,
        },
        cmdline = {
          keymap = { ["<CR>"] = { "fallback" } },
        },
        completion = {
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          menu = {
            draw = {
              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
          },
          ghost_text = {
            enabled = true,
          },
          list = { selection = { preselect = false, auto_insert = true } },
        },
        signature = { enabled = true },
      })
    end,
  },
  {
    "colorful-menu.nvim",
    on_require = "colorful-menu",
  },
  {
    "friendly-snippets",
    dep_of = "blink.cmp",
  },
}
