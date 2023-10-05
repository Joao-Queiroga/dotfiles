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
	},
	{
		"lambdalisue/suda.vim",
		init = function()
			vim.g.suda_smart_edit = 1
		end,
	},
	{
		"gentoo/gentoo-syntax",
	},
}
