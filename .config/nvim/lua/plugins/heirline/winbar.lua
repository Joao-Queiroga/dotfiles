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
		hl = "NavicSeparator",
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
		provider = function(self)
			return self.filename
		end,
		hl = "NavicText",
	},
	update = { "BufRead", "BufNewFile" },
}

local navic = {
	init = function(self)
		local data = require("nvim-navic").get_data()
		local children = {}
		if #data > 0 then
			table.insert(children, {
				provider = " › ",
				hl = "NavicSeparator",
			})
		end
		for i, d in ipairs(data) do
			local child = {
				{
					provider = d.icon,
				},
				{
					provider = d.name,
				},
				hl = "NavicIcons" .. d.type,
			}
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = " › ",
					hl = "NavicSeparator",
				})
			end
			table.insert(children, child)
		end
		self.child = self:new(children, 1)
	end,
	provider = function(self)
		return self.child:eval()
	end,
	condition = function()
		return require("nvim-navic").is_available()
	end,
	update = "CursorMoved",
}

return {
	current_file,
	navic,
}
