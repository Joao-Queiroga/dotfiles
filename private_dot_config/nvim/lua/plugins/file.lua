return {
	{
		'echasnovski/mini.files',
		opts = {
			windows = {
				preview = true,
				width_preview = 40
			}
		}
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		opts = require'plugins.config.nvim-tree',
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
}
