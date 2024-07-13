local ensure_installed = {
	"javadbg",
	"javatest",
}

return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>d", "", desc = "Debug" },
			{
				"<leader>db",
				"<cmd>DapToggleBreakpoint<CR>",
				mode = { "n", "v", "x" },
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dc",
				"<cmd>DapContinue<CR>",
				mode = { "n", "v", "x" },
				desc = "Continue",
			},
		},
		event = "VeryLazy",
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = ensure_installed,
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{
				"<leader>dt",
				"<cmd>lua require('dapui').toggle()<CR>",
				mode = { "n", "v", "x" },
				desc = "Toggle UI",
			},
			{
				"<leader>dr",
				"<cmd>lua require('dapui').open({ reset = true })<CR>",
				mode = { "n", "v", "x" },
				desc = "Reset UI",
			},
		},
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		opts = {},
		config = function(_, opts)
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dapui.setup(opts)
		end,
	},
}
