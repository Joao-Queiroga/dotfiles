local current_file = {
	init = function(self)
		self.filepath = vim.api.nvim_buf_get_name(0)
	end,
	{
		provider = " ",
		hl = { link = "Function" },
	},
	{
		init = function(self)
			self.dirname = vim.fn.fnamemodify(self.filepath, ":p:h:t")
		end,
		provider = function(self)
			return self.dirname
		end,
		hl = "NavicText",
	},
	{
		provider = " › ",
		hl = "NavicSeparator"
	},
	{
		init = function(self)
			local extension = vim.fn.fnamemodify(self.filepath, ":e")
			self.icon, self.icon_color =
				require("nvim-web-devicons").get_icon_color(self.filepath, extension, { default = true })
		end,
		provider = function(self)
			return self.icon .. " "
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
	},
	{
		init = function(self)
			self.filename = vim.fn.fnamemodify(self.filepath, ":t")
		end,
		provider = function (self)
			return self.filename
		end,
		hl = "NavicText",
	},
	update = { "BufRead", "BufNewFile" }
}

local navic = {
	init = function(self)
		local navic = require("nvim-navic")
		local data = navic.get_data()
		for i, context in pairs(data) do
			data[i].name = "%#NavicIcons" .. context.type .. "#" .. context.name .. "%*"
		end
		self.navic = navic.format_data(data, { safe_output = false })
	end,
	{
		provider = " › ",
		hl = "NavicSeparator",
		condition = function(self)
			return #self.navic > 0
		end,
	},
	{
		provider = function(self)
			return self.navic
		end,
	},
	condition = function()
		return require("nvim-navic").is_available()
	end,
	update = "CursorMoved",
}

return {
	current_file,
	navic
}
