return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
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
}
