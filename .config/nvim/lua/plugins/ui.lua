return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = require("plugins.config.bufferline"),
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			presets = { inc_rename = true },
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = { char = "│" },
			scope = { enabled = false },
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
		"echasnovski/mini.indentscope",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			symbol = "│",
			draw = { delay = 0 },
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
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
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				insert_only = false,
				start_in_insert = false,
			},
			select = {
				backend = { "builtin", "nui" },
			},
		},
	},
	{
		"folke/which-key.nvim",
		lazy = true,
		opts = {},
	},
}
