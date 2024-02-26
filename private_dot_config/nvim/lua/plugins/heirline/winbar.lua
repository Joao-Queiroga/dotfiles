local current_file = {
	init = function(self)
		self.filepath = vim.api.nvim_buf_get_name(0)
		self.filename = vim.fn.fnamemodify(self.filepath, ":t")
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
			local filename = self.filename
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color =
				require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self)
			return self.icon .. " "
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
		update = "BufEnter",
	},
	{
		provider = function(self)
			return self.filename
		end,
		hl = "NavicText",
	},
	update = { "BufRead", "BufNewFile", "BufEnter", "Filetype" },
}

local navic = {
	init = function(self)
		local data = require("nvim-navic").get_data() or {}
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
	update = { "CursorMoved", "LspAttach" },
}

return { current_file, navic, { provider = "%=" }, hl = "Normal" }
