return {
	{
		'hrsh7th/nvim-cmp',
		event = "InsertEnter",
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'dcampos/nvim-snippy',
			'hrsh7th/cmp-nvim-lsp',
			'zbirenbaum/copilot-cmp',
		},
		config = function()
			require('plugins.completion.cmp')
		end
	},
	{
		'dcampos/nvim-snippy',
		keys = {
			{ '<Tab>', mode = { 'i', 'x' } },
			'g<Tab>',
		},
		ft = 'snippets',
		dependencies = {
			"honza/vim-snippets",
		},
		cmd = { 'SnippyEdit', 'SnippyReload' },
	}
}
