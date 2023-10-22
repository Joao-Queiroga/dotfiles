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
		opts = {
			winbar = require("plugins.heirline.winbar"),
			opts = {
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
		},
	},
}
