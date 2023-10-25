return {
	{
		"nvim-treesitter/nvim-treesitter",
		event =  { "BufRead", "BufNewFile", "VeryLazy" },
		dependencies = {
			"nvim-treesitter/playground",
			"hiphish/rainbow-delimiters.nvim",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-refactor",
			"luckasRanarison/tree-sitter-hypr",
		},
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("plugins.treesitter.config")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
}
