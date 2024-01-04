local utils = require("heirline.utils")
local tabline_file_name = {
	provider = function(self)
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return { bold = self.is_active or self.is_visible, italic = true }
	end,
}

local tabline_file_flags = {
	init = function(self)
		self.pad = math.ceil(self.padding)
	end,
	{
		condition = function(self)
			return vim.api.nvim_buf_get_option(self.bufnr, "modified")
		end,
		provider = function(self)
			return "[+]" .. string.rep(" ", self.pad - 3)
		end,
		hl = { fg = "green" },
	},
	{
		condition = function(self)
			return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
				or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
		end,
		provider = function(self)
			if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
				return "  " .. string.rep(" ", self.pad - 3)
			else
				return "" .. string.rep(" ", self.pad - 1)
			end
		end,
		hl = { fg = "orange" },
	},
	{
		condition = function(self)
			return vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
				and not vim.api.nvim_buf_get_option(self.bufnr, "readonly")
				and not vim.api.nvim_buf_get_option(self.bufnr, "modified")
		end,
		provider = function(self)
			return string.rep(" ", self.pad)
		end,
	},
}

local file_icon = {
	init = function(self)
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color_by_filetype(vim.bo[self.bufnr].filetype, { default = true })
	end,
	provider = function(self)
		return self.icon .. " "
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
	update = { "FileType", "BufEnter", "BufLeave" },
}

local tabline_filename_block = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
		self.padding = (25 - (utils.count_chars(vim.fn.fnamemodify(self.filename, ":t")) + 2)) / 2
	end,
	hl = function(self)
		if self.is_active then
			return "Normal"
		else
			return "TabLine"
		end
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
			return (self.is_active and "▎" or " ") .. string.rep(" ", math.floor(self.padding) - 1)
		end,
		hl = { fg = utils.get_highlight("TabLineSel").bg },
	},
	file_icon,
	tabline_file_name,
	tabline_file_flags,
}

local get_bufs = function()
	return vim.tbl_filter(function(bufnr)
		return vim.api.nvim_buf_get_option(bufnr, "buflisted")
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
	-- by the way, open a lot of buffers and try clicking them ;)
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
		if not self.is_active then
			return "TabLine"
		else
			return "TabLineSel"
		end
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
