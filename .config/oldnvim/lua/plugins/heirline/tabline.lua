local utils = require("heirline.utils")
local tabline_file_name = {
	provider = function(self)
		return self.filename == "" and "[No Name]" or self.filename
	end,
	hl = function(self)
		return { bold = self.is_active or self.is_visible, italic = true }
	end,
}

local tabline_file_flags = {
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
		end,
		provider = function()
			return "[+]"
		end,
		hl = { fg = "green" },
	},
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
				or not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
		end,
		provider = function(self)
			return vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" and " " or " "
		end,
		hl = { fg = "orange" },
	},
}

local file_icon = {
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
	update = { "BufEnter", "BufLeave" },
}

local tabline_filename_block = {
	init = function(self)
		self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")
		local filechars = utils.count_chars(self.filename)
		self.padding = filechars < 23 and (23 - filechars) / 2 or 1
	end,
	hl = function(self)
		return self.is_active and "Normal" or "TabLine"
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then -- close on mouse middle click
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	{
		provider = function(self)
			return "%-" .. math.ceil(self.padding) .. "("
		end,
	},
	{
		provider = "▎",
		condition = function(self)
			return self.is_active
		end,
		hl = { fg = utils.get_highlight("TabLineSel").bg },
	},
	{ provider = "%)" },
	file_icon,
	tabline_file_name,
	{
		provider = function(self)
			return "%" .. math.ceil(self.padding) .. "("
		end,
	},
	tabline_file_flags,
	{ provider = "%)" },
}

local get_bufs = function()
	return vim.tbl_filter(function(bufnr)
		return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
	end, vim.api.nvim_list_bufs())
end

local buflist_cache = {}

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
	callback = function()
		vim.schedule(function()
			local buffers = get_bufs()
			for i, v in ipairs(buffers) do
				buflist_cache[i] = v
			end
			for i = #buffers + 1, #buflist_cache do
				buflist_cache[i] = nil
			end

			-- check how many buffers we have and set showtabline accordingly
			if #buflist_cache > 1 then
				vim.o.showtabline = 2 -- always
			elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
				vim.o.showtabline = 1 -- only when #tabpages > 1
			end
		end)
	end,
})

local TabLineOffset = {
	condition = function(self)
		local win = vim.api.nvim_tabpage_list_wins(0)[1]
		local bufnr = vim.api.nvim_win_get_buf(win)
		self.winid = win

		if vim.bo[bufnr].filetype == "neo-tree" then
			self.title = "File Explorer"
			return true
		end
	end,

	provider = function(self)
		local title = self.title
		local width = vim.api.nvim_win_get_width(self.winid)
		local pad = math.ceil((width - #title) / 2)
		return string.rep(" ", pad) .. title .. string.rep(" ", pad)
	end,

	hl = "TabLine",
}

local bufferline = utils.make_buflist(
	{
		tabline_filename_block,
	},
	{ provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
	{ provider = "", hl = { fg = "gray" } }, -- right trunctation, also optional (defaults to ...... yep, ">")
	function()
		return buflist_cache
	end,
	false
)

local tabpage = {
	provider = function(self)
		return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
	end,
	hl = function(self)
		return self.is_active and "TabLineSel" or "TabLine"
	end,
}

local tab_pages = {
	-- only show this component if there's 2 or more tabpages
	condition = function()
		return #vim.api.nvim_list_tabpages() >= 2
	end,
	{ provider = "%=" },
	utils.make_tablist(tabpage),
}

return { TabLineOffset, bufferline, { provider = "%=" }, tab_pages }
