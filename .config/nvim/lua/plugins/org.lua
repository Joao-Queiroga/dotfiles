return {
	{
		"nvim-orgmode/orgmode",
		ft = "org",
		keys = {
			{ "<leader>o", "", desc = "Org Mode" },
			{ "<leader>oa", desc = "Org Agenda" },
			{ "<leader>oc", desc = "Org Capture" },
		},
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
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
