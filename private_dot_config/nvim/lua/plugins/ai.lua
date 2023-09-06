return {
	{
		"jackMort/ChatGPT.nvim",
		cmd = {
			"ChatGPT",
			"ChatGPTActAs",
			"ChatGPTCompleteCode",
			"ChatGPTEditWithInstructions",
			"ChatGPTRun"
		},
		opts = {
			api_key_cmd = "pass keys/chatgpt.nvim"
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		}
	},
	{
		'zbirenbaum/copilot.lua',
		lazy = true,
		cmd = "Copilot",
		opts = {}
	},
	{
		"zbirenbaum/copilot-cmp",
		lazy = true,
		dependencies = "zbirenbaum/copilot.lua",
		opts = {},
	},
}
