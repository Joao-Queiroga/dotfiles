local highlight = vim.api.nvim_set_hl
local colors = require'tokyonight.colors'.setup()

highlight(0, "RainbowDelimiterRed", { fg = colors.red })
highlight(0, "RainbowDelimiterYellow", { fg = colors.yellow })
highlight(0, "RainbowDelimiterBlue", { fg = colors.purple })
highlight(0, "RainbowDelimiterOrange", { fg = colors.orange })
highlight(0, "RainbowDelimiterGreen", { fg = colors.green })
highlight(0, "RainbowDelimiterViolet", { fg = colors.magenta })
highlight(0, "RainbowDelimiterCyan", { fg = colors.cyan })

highlight(0, "IndentBlanklineContextChar", { fg = colors.magenta })
