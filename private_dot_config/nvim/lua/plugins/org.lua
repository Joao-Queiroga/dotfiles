return {
	{
		"nvim-orgmode/orgmode",
		ft = "org",
		keys = { "<leader>oa", "<leader>oc" },
		build = ":TSUpdate org",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			require("orgmode").setup_ts_grammar()
			require("orgmode").setup(opts)
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		ft = "org",
		dependencies = {
			"nvim-orgmode/orgmode",
		},
		opts = {
			concealcursor = true,
			symbols = {
				headlines = { "⦿", "○", "●", "○", "●", "○", "●" },
			},
		},
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "markdown", "org", "norg" },
		opts = {},
	},
}
