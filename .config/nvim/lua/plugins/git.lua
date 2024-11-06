---@type LazySpec[]
return {
	{
		"purarue/gitsigns-yadm.nvim",
		lazy = true,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			opts = {
				_on_attach_pre = function(_, callback)
					require("gitsigns-yadm").yadm_signs(callback)
				end,
			},
		},
		enabled = vim.fn.executable("yadm") == 1,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "󰐊" },
				topdelete = { text = "󰐊" },
				changedelete = { text = "▎" },
			},
		},
	},
}
