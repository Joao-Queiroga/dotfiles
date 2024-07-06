return {
	{
		"jackMort/ChatGPT.nvim",
		keys = {
			{ "<leader>C", "", mode = { "n", "v", "x" }, desc = "GPT" },
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
			api_key_cmd = "rbw get chatgpt.nvim",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		opts = {},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		branch = "canary",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
		},
		opts = {},
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		init = function()
			vim.g.codeium_disable_bindings = 1
		end,
		keys = {
			{
				"<c-g>",
				function()
					return vim.fn["codeium#Accept"]()
				end,
				mode = "i",
				expr = true,
				silent = true,
			},
			{
				"<c-;>",
				function()
					return vim.fn["codeium#CycleCompletions"](1)
				end,
				mode = "i",
				expr = true,
				silent = true,
			},
			{
				"<c-,>",
				function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end,
				mode = "i",
				expr = true,
				silent = true,
			},
			{
				"<c-x>",
				function()
					return vim.fn["codeium#Clear"]()
				end,
				mode = "i",
				expr = true,
				silent = true,
			},
		},
	},
}
