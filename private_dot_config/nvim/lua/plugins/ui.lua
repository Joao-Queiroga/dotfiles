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
			"rcarriga/nvim-notify",
		}
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			render = 'simple',
		},
		config = function (_, opts)
			local notify = require('notify')
			notify.setup(opts)
			vim.notify = notify
		end
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		event = "VeryLazy",
		opts = {
			filetype_exclude = {
				"help",
				"terminal",
				"dashboard",
				"lazy",
				"lspinfo",
				"mason",
				"TelescopePrompt",
				"TelescopeResults",
				"noice"
			},
			show_current_context = true,
		}
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
