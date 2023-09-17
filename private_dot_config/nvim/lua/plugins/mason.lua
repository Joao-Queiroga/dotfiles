return {
	{
		'williamboman/mason.nvim',
		lazy = true,
		cmd = "Mason";
		opts = {
			ui = {
				icons = {
					package_pending = " ",
					package_installed = "󰄳 ",
					package_uninstalled = " 󰚌",
				}
			}
		},
	},
}
