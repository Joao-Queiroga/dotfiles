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

local function highlight()
	vim.api.nvim_set_hl(0, "NavicIconsFile", { link = "Tag" })
	vim.api.nvim_set_hl(0, "NavicIconsModule", { link = "Exception" })
	vim.api.nvim_set_hl(0, "NavicIconsNamespace", { link = "Include" })
	vim.api.nvim_set_hl(0, "NavicIconsClass", { link = "Type" })
	vim.api.nvim_set_hl(0, "NavicIconsMethod", { link = "Function" })
	vim.api.nvim_set_hl(0, "NavicIconsConstructor", { link = "@constructor" })
	vim.api.nvim_set_hl(0, "NavicIconsEnum", { link = "@number" })
	vim.api.nvim_set_hl(0, "NavicIconsInterface", { link = "Type" })
	vim.api.nvim_set_hl(0, "NavicIconsFunction", { link = "Function" })
	vim.api.nvim_set_hl(0, "NavicIconsVariable", { link = "@variable" })
	vim.api.nvim_set_hl(0, "NavicIconsConstant", { link = "Constant" })
	vim.api.nvim_set_hl(0, "NavicIconsString", { link = "String" })
	vim.api.nvim_set_hl(0, "NavicIconsNumber", { link = "Number" })
	vim.api.nvim_set_hl(0, "NavicIconsBoolean", { link = "Boolean" })
	vim.api.nvim_set_hl(0, "NavicIconsArray", { link = "Type" })
	vim.api.nvim_set_hl(0, "NavicIconsObject", { link = "Type" })
	vim.api.nvim_set_hl(0, "NavicIconsKey", { link = "Constant" })
	vim.api.nvim_set_hl(0, "NavicIconsNull", { link = "Constant" })
	vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { link = "Number" })
	vim.api.nvim_set_hl(0, "NavicIconsStruct", { link = "Type" })
	vim.api.nvim_set_hl(0, "NavicIconsEvent", { link = "Constant" })
	vim.api.nvim_set_hl(0, "NavicIconsOperator", { link = "Operator" })
	vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { link = "Type" })
	vim.api.nvim_set_hl(0, "NavicText", { link = "Comment" })
	vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Operator" })
end

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
		config = function(_, opts)
			highlight()
			require('nvim-navic').setup(opts)
		end,
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
