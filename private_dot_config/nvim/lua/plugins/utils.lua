return {
	{
		'alexghergh/nvim-tmux-navigation',
		event = "VeryLazy",
		opts = {}
	},
	{
		'uga-rosa/ccc.nvim',
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			}
		}
	},
	{
		'echasnovski/mini.align',
		keys = {
			"ga",
			"gA",
			{"ga", mode = "v"},
			{"gA", mode = "v"},
		},
		version = '*',
		opts = {
			mappings = {
				start_with_preview = 'ga',
				start = 'gA',
			}
		}
	},
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		keys = {{"<C-t>", mode = { "i", "n" }}},
		opts = {
			size = 14,
			open_mapping = [[<c-t>]],
		},
	},
	{
		'dhruvasagar/vim-table-mode',
		event = "VeryLazy"
	},
	{
		'lambdalisue/suda.vim',
		init = function ()
			vim.g.suda_smart_edit = 1
		end
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		enabled = false,
		-- stylua: ignore
		keys = {
			-- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			-- { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
	{
		'gentoo/gentoo-syntax'
	}
}
