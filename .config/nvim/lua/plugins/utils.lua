return {
	{
		"numToStr/Navigator.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"uga-rosa/ccc.nvim",
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		},
	},
	{
		"echasnovski/mini.align",
		keys = {
			{ "ga", mode = { "n", "v" } },
			{ "gA", mode = { "n", "v" } },
		},
		version = "*",
		opts = {
			mappings = {
				start_with_preview = "ga",
				start = "gA",
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = { { "<C-t>", mode = { "i", "n" } } },
		opts = {
			size = 14,
			open_mapping = [[<c-t>]],
		},
	},
	{
		"dhruvasagar/vim-table-mode",
		event = "VeryLazy",
		init = function()
			vim.g.table_mode_corner = "|"
			vim.g.table_mode_header = "-"
			vim.g.table_mode_hl_cells = 1
		end,
	},
	{
		"lambdalisue/suda.vim",
		init = function()
			vim.g.suda_smart_edit = 1
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
	},
	{
		"gentoo/gentoo-syntax",
	},
}
