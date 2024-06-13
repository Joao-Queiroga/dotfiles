local function setup_colors()
	local utils = require("heirline.utils")
	return {
		bg_highlight = utils.get_highlight("CursorLine").bg,
		bg = utils.get_highlight("StatusLine").bg,
		fg_bright = utils.get_highlight("Folded").fg,
		red = utils.get_highlight("DiagnosticError").fg,
		dark_red = utils.get_highlight("DiffDelete").bg,
		green = utils.get_highlight("String").fg,
		blue = utils.get_highlight("Function").fg,
		gray = utils.get_highlight("NonText").fg,
		orange = utils.get_highlight("Constant").fg,
		purple = utils.get_highlight("@keyword").fg,
		magenta = utils.get_highlight("Statement").fg,
		cyan = utils.get_highlight("Keyword").fg,
		git_del = utils.get_highlight("diffRemoved").fg,
		git_add = utils.get_highlight("diffAdded").fg,
		git_change = utils.get_highlight("diffChanged").fg,
	}
end
return {
	{
		"rebelot/heirline.nvim",
		-- You can optionally lazy-load heirline on UiEnter
		-- to make sure all required plugins and colorschemes are loaded before setup
		event = "UiEnter",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.api.nvim_create_augroup("Heirline", { clear = true })
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					require("heirline.utils").on_colorscheme(setup_colors)
				end,
				group = "Heirline",
			})
		end,
		opts = function()
			return {
				winbar = require("plugins.heirline.winbar"),
				statusline = require("plugins.heirline.statusline"),
				tabline = require("plugins.heirline.tabline"),
				opts = {
					colors = setup_colors,
					disable_winbar_cb = function(args)
						return require("heirline.conditions").buffer_matches({
							buftype = { "nofile", "prompt", "help", "quickfix" },
							filetype = {
								"^git.*",
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
							},
						}, args.buf)
					end,
				},
			}
		end,
	},
}
