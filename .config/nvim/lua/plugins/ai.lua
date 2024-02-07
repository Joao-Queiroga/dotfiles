return {
	{
		"jackMort/ChatGPT.nvim",
		keys = {
			{ "<leader>Cc", ":ChatGPT<CR>", mode = { "n", "v", "x" }, desc = "ChatGPT" },
			{
				"<leader>Ce",
				":ChatGPTEditWithInstruction<CR>",
				mode = { "n", "v", "x" },
				desc = "Edit with instruction",
			},
			{
				"<leader>Cg",
				":ChatGPTRun grammar_correction<CR>",
				mode = { "n", "v", "x" },
				desc = "Grammar Correction",
			},
			{ "<leader>Ct", ":ChatGPTRun translate<CR>", mode = { "n", "v", "x" }, desc = "Translate" },
			{ "<leader>Ck", ":ChatGPTRun keywords<CR>", mode = { "n", "v", "x" }, desc = "Keywords" },
			{ "<leader>Cd", ":ChatGPTRun docstring<CR>", mode = { "n", "v", "x" }, desc = "Docstring" },
			{ "<leader>Ca", ":ChatGPTRun add_tests<CR>", mode = { "n", "v", "x" }, desc = "Add Tests" },
			{ "<leader>Co", ":ChatGPTRun optimize_code<CR>", mode = { "n", "v", "x" }, desc = "Optimize Code" },
			{ "<leader>Cs", ":ChatGPTRun summarize<CR>", mode = { "n", "v", "x" }, desc = "Summarize" },
			{ "<leader>Cf", ":ChatGPTRun fix_bugs<CR>", mode = { "n", "v", "x" }, desc = "Fix Bugs" },
			{ "<leader>Cx", ":ChatGPTRun explain_code<CR>", mode = { "n", "v", "x" }, desc = "Explain Code" },
			{ "<leader>Cr", ":ChatGPTRun roxygen_edit<CR>", mode = { "n", "v", "x" }, desc = "Roxygen Edit" },
			{
				"<leader>Cl",
				":ChatGPTRun code_readability_analysis<CR>",
				mode = { "n", "v", "x" },
				desc = "Code Readability Analysis",
			},
		},
		cmd = {
			"ChatGPT",
			"ChatGPTActAs",
			"ChatGPTCompleteCode",
			"ChatGPTEditWithInstructions",
			"ChatGPTRun",
		},
		opts = {
			api_key_cmd = "gopass --nosync keys/chatgpt.nvim",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		opts = {},
	},
	{
		"zbirenbaum/copilot-cmp",
		lazy = true,
		dependencies = "zbirenbaum/copilot.lua",
		opts = {},
	},
	{
		"Exafunction/codeium.nvim",
		cmd = "Codeium",
		event = "InsertEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {},
	},
}
