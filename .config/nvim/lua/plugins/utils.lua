---@type LazySpec[]
return {
	{
		"christoomey/vim-tmux-navigator",
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
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
			{ "<leader>c", "<cmd>lua MiniBufremove.delete()<cr>", mode = { "n", "v" }, desc = "Delete buffer" },
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
		cmd = {
			"TableModeToggle",
			"TableModeEnable",
		},
		keys = {
			{ "<leader>t", "", desc = "Table Mode" },
			{ "<leader>tm", desc = "Toggle" },
			{ "<leader>tt", desc = "Tableize" },
			{ "<leader>tr", desc = "Realign" },
			{ "<leader>ts", desc = "Sort" },
			{ "<leader>ti", "", desc = "Insert Column" },
			{ "<leader>tic", desc = "After" },
			{ "<leader>tiC", desc = "Before" },
			{ "<leader>td", "", desc = "Delete" },
			{ "<leader>tdr", desc = "Row" },
			{ "<leader>tdc", desc = "Column" },
			{ "<leader>tf", "", desc = "Formula" },
			{ "<leader>tfa", desc = "Add" },
			{ "<leader>tfe", desc = "Eval" },
		},
		init = function()
			vim.g.table_mode_corner = "|"
			vim.g.table_mode_header = "-"
			vim.g.table_mode_hl_cells = 1
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		main = "render-markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = "markdown",
		opts = {},
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
		commit = "deb158d",
		enabled = vim.fn.executable("magick") == 1,
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
	},
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_filetypes = {
				"NvimTree",
				"copilot-chat",
				"TelescopePrompt",
				"aerial",
				"alpha",
				"checkhealth",
				"dapui*",
				"Diffview*",
				"Dressing*",
				"help",
				"httpResult",
				"lazy",
				"lspinfo",
				"Neogit*",
				"mason",
				"neotest%-summary",
				"minifiles",
				"neo%-tree*",
				"netrw",
				"noice",
				"notify",
				"prompt",
				"qf",
				"query",
				"oil",
				"undotree",
				"trouble",
				"Trouble",
				"fugitive",
			},
		},
	},
	{
		"mistricky/codesnap.nvim",
		build = "make && mkdir -p ~/Imagens/CodeSnap/",
		cmd = { "CodeSnap", "CodeSnapSave" },
		opts = {
			save_path = "~/Imagens/CodeSnap/",
		},
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		"https://gitlab.com/itaranto/plantuml.nvim",
		ft = "plantuml",
		version = "*",
		opts = {
			renderer = {
				type = "imv",
				options = {
					dark_mode = true,
					format = "svg", -- Allowed values: nil, 'png', 'svg'.
				},
			},
		},
	},
}
