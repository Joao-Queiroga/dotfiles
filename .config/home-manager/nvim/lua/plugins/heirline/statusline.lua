local utils = require("heirline.utils")
local conditions = require("heirline.conditions")
local surround = function(delimiter, color, component)
  return {
    utils.surround(delimiter, color.fg or color, component),
    hl = { bg = color.bg or nil },
  }
end

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
    self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  end,
}

local file_icon = {
  init = function(self)
    self.icon, self.icon_color = MiniIcons.get("file", self.filename)
  end,
  provider = function(self)
    return self.icon .. " "
  end,
  hl = function(self)
    return self.icon_color
  end,
  update = "BufEnter",
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
  hl = { fg = "blue" },
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
    error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
    warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
    info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
    hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
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

local filetype = {
  init = function(self)
    local filetype = vim.bo.filetype
    self.filetype = filetype == "" and "text" or filetype
  end,
  {
    init = function(self)
      self.icon, self.icon_color, _ = MiniIcons.get("filetype", self.filetype)
    end,
    provider = function(self)
      return self.icon .. " "
    end,
    hl = function(self)
      return self.icon_color
    end,
  },
  {
    provider = function(self)
      return self.filetype .. " "
    end,
    hl = { fg = "blue" },
  },
  update = "FileType",
}

local ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
  hl = { bg = "blue", fg = "bg" },
}

return {
  surround({ "", "" }, "bg_highlight", vi_mode),
  diagnostics,
  file_name_block,
  { provider = "%=" },
  surround({ "" }, "bg_highlight", filetype),
  surround({ "" }, { fg = "blue", bg = "bg_highlight" }, ruler),

  hl = { bg = "bg" },
  condition = exlude,
}
