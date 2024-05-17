return {
	{
		"numToStr/Navigator.nvim",
		keys = {
			{ "<C-h>", "<cmd>NavigatorLeft<cr>", mode = { "n", "t", "v", "x" }, desc = "Navigate Left" },
			{ "<C-j>", "<cmd>NavigatorDown<cr>", mode = { "n", "t", "v", "x" }, desc = "Navigate Down" },
			{ "<C-k>", "<cmd>NavigatorUp<cr>", mode = { "n", "t", "v", "x" }, desc = "Navigate Up" },
			{ "<C-l>", "<cmd>NavigatorRight<cr>", mode = { "n", "t", "v", "x" }, desc = "Navigate Right" },
		},
		opts = {},
	},
	{
		"uga-rosa/ccc.nvim",
		event = { "BufReadPre", "BufNewFile" },
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
		"echasnovski/mini.move",
		keys = {
			{ "<M-h>", mode = { "n", "v" } },
			{ "<M-j>", mode = { "n", "v" } },
			{ "<M-k>", mode = { "n", "v" } },
			{ "<M-l>", mode = { "n", "v" } },
		},
		opts = {},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{ "<leader>c", "<cmd>lua MiniBufremove.delete()<cr>", mode = { "n", "t" }, desc = "Delete buffer" },
		},
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
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			vim.g.suda_smart_edit = 1
		end,
	},
	{
		"3rd/image.nvim",
		event = { "BufRead", "BufNewFile", "VeryLazy" },
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		"gentoo/gentoo-syntax",
		event = "BufReadPre",
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		opts = {
			rocks = { "magick" },
		},
	},
}
