return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		keys = {
			{ "gsa", desc = "Add surrounding", mode = { "n", "v" } },
			{ "gsd", desc = "Delete surrounding", mode = { "n", "v" } },
			{ "gsf", desc = "Find surrounding (to the right)" },
			{ "gsF", desc = "Find surrounding (to the left)" },
			{ "gsh", desc = "Highlight surrounding", mode = { "n", "v" } },
			{ "gsr", desc = "Replace surrounding", mode = { "n", "v" } },
			{ "gsn", desc = "Update `n_lines`", mode = { "n", "v" } },
		},
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.config.autopairs")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("project_nvim").setup()
			require("telescope").load_extension("projects")
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufRead", "BufNewFile" },
		dependencies = "kevinhwang91/promise-async",
		opts = {},
	},
	{
		"elkowar/yuck.vim",
		ft = "yuck",
	},
}
