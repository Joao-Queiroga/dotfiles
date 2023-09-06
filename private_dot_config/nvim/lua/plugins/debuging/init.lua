return {
	{
		'mfussenegger/nvim-dap',
		event = "VeryLazy",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			'mfussenegger/nvim-dap',
		},
		opts = {},
		config = function (opts)
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dapui.setup(opts)
		end
	}
}
