return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			on_highlights = function(hl, c)
				local prompt = "#2d3149"
				hl.TelescopeNormal = {
					bg = c.bg_dark,
					fg = c.fg_dark,
				}
				hl.TelescopeBorder = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopePromptNormal = {
					bg = prompt,
				}
				hl.TelescopePromptBorder = {
					bg = prompt,
					fg = prompt,
				}
				hl.TelescopePromptTitle = {
					bg = prompt,
					fg = prompt,
				}
				hl.TelescopePreviewTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopeResultsTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				-- hl.NavicIconsFile =          { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsModule =        { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsNamespace =     { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsPackage =       { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsClass =         { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsMethod =        { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsProperty =      { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsField =         { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsConstructor =   { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsEnum =          { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsInterface =     { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsFunction =      { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsVariable =      { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsConstant =      { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsString =        { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsNumber =        { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsBoolean =       { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsArray =         { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsObject =        { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsKey =           { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsNull =          { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsEnumMember =    { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsStruct =        { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsEvent =         { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsOperator =      { fg = "#ffffff", bg = "#000000" }
				-- hl.NavicIconsTypeParameter = { fg = "#ffffff", bg = "#000000" }
				hl.NavicSeparator =          { fg = c.cyan }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme([[tokyonight]])
		end,
	},
}
