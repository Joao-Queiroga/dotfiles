local symbols = {
	File = " ",
	Module = " ",
	Namespace = " ",
	Package = " ",
	Class = " ",
	Method = " ",
	Property = " ",
	Field = " ",
	Constructor = " ",
	Enum = " ",
	Interface = " ",
	Function = "󰡱 ",
	Variable = " ",
	Constant = " ",
	String = "󰅳 ",
	Number = "󰎠 ",
	Boolean = " ",
	Array = "󰅨 ",
	Object = " ",
	Key = " ",
	Null = "󰟢 ",
	EnumMember = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}

return {
	{
		"SmiteshP/nvim-navic",
		event = "LspAttach",
		opts = {
			icons = symbols,
			lsp = {
				auto_attach = true,
			},
			highlight = true,
			separator = " › ",
		},
	},
	{
		"SmiteshP/nvim-navbuddy",
		event = "LspAttach",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			icons = symbols,
			lsp = {
				auto_attach = true,
			},
		},
	},
}
