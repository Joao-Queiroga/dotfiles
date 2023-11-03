local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

local function exlude(args)
	return not conditions.buffer_matches({
		buftype = { "nofile", "prompt", "help", "quickfix" },
		filetype = {
			"^git.*",
			"help",
			"startify",
			"dashboard",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"alpha",
			"spectre_panel",
			"toggleterm",
			"neo-tree",
			"neo-tree-popup",
			"notify",
		},
	}, args.buf)
end

local vi_mode = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	static = {
		mode_names = {
			n = "N",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "V",
			vs = "Vs",
			V = "V_",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "I",
			ic = "Ic",
			ix = "Ix",
			R = "R",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "C",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "T",
		},
		mode_colors = {
			n = "blue",
			i = "green",
			v = "magenta",
			V = "magenta",
			["^V"] = "magenta",
			["\22"] = "cyan",
			c = "orange",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "red",
			r = "red",
			["!"] = "red",
			t = "cyan",
		},
	},
	provider = function(self)
		return "%2(" .. self.mode_names[self.mode] .. "%)"
	end,
	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return { fg = self.mode_colors[mode], bold = true }
	end,
	update = "ModeChanged",
}

local file_name_block = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local file_icon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local file_name = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":t")
		if filename == "" then
			return "[No Name]"
		end
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = utils.get_highlight("Directory").fg },
}

local file_flags = {
	{ provider = " " },
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "[+]",
		hl = { fg = "green" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = "",
		hl = { fg = "orange" },
	},
}

file_name_block = utils.insert(
	file_name_block,
	{ provider = " " },
	file_icon,
	file_name,
	file_flags,
	{ provider = "%<" }
)

local diagnostics = {
	conditions = conditions.has_diagnostics,

	static = {
		error_icon = " ",
		warn_icon = " ",
		info_icon = " ",
		hint_icon = " ",
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = " ",
		condition = function(self)
			return self.errors + self.warnings + self.hints + self.info > 0
		end,
	},
	{
		provider = function(self)
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = "DiagnosticError",
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = "DiagnosticWarn",
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = "DiagnosticInfo",
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = "DiagnosticHint",
	},
}

local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%2c %P",
}

-- local ScrollBar = {
-- 	static = {
-- 		sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
-- 	},
-- 	provider = function(self)
-- 		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
-- 		local lines = vim.api.nvim_buf_line_count(0)
-- 		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
-- 		return string.rep(self.sbar[i], 2)
-- 	end,
-- 	hl = { fg = "blue", bg = "bg_highlight" },
-- }

return {
	utils.surround({ "", "" }, "bg_highlight", { vi_mode }),
	diagnostics,
	file_name_block,
	{ provider = "%=" },
	Ruler,
	-- ScrollBar,

	hl = { bg = "bg" },
	condition = exlude,
}
