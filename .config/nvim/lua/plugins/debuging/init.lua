local ensure_installed = {
	'java-debug-adapter'
}

return {
	{
		'mfussenegger/nvim-dap',
		event = "VeryLazy",
	},
	{
    "jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			'williamboman/mason.nvim',
			'mfussenegger/nvim-dap',
		},
		opts = {
			ensure_installed = ensure_installed
		},
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
