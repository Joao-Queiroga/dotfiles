return {
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = require'plugins.config.lualine',
	},
	{
		'akinsho/bufferline.nvim',
		event = "VeryLazy",
		opts = require'plugins.config.bufferline',
	},
	{
		"folke/noice.nvim",
		opts = {
			presets = { inc_rename = true },
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		}
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = { char = "│" },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{
		'stevearc/dressing.nvim',
		event = "VeryLazy",
		opts = {
			input = {
				insert_only = false,
				start_in_insert = false,
			},
			select = {
				backend = { 'builtin', 'nui' },
			}
		},
	},
	{
		'folke/which-key.nvim',
		lazy = true,
		opts = {}
	},

}
