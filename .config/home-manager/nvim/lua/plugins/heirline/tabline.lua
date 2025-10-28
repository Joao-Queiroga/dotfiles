local utils = require("heirline.utils")
local buflist_cache = {}

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
    self.icon, self.icon_hl, _ = MiniIcons.get("file", self.filename)
  end,
  provider = function(self)
    return self.icon .. " "
  end,
  hl = function(self)
    return self.icon_hl
  end,
  update = { "BufEnter", "BufLeave" },
}

local function stringdelimiter(str, maxChars)
  local len = utils.count_chars(str)
  if len <= maxChars then
    return str
  end

  -- Encontra o último espaço antes do limite
  local ultimoEspaco = 0
  for i = 1, maxChars do
    if str:sub(i, i) == " " then
      ultimoEspaco = i
    end
  end

  -- Se não houver espaço, corta no limite
  if ultimoEspaco == 0 then
    ultimoEspaco = maxChars
  end

  -- Retorna a string cortada até o último espaço com reticências
  return str:sub(1, ultimoEspaco - 1) .. "…"
end

local function display_name(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local filename = vim.fn.fnamemodify(path, ":t")

  -- conta quantos buffers têm o mesmo nome
  local count = 0
  for _, b in ipairs(buflist_cache) do
    if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":t") == filename then
      count = count + 1
    end
  end

  local result
  if count == 1 then
    result = stringdelimiter(filename, 18) -- único, só o nome
  else
    -- relativo ao cwd
    local rel = vim.fn.fnamemodify(path, ":.:")
    -- pega só o último diretório + arquivo
    local parts = vim.split(rel, "/", { plain = true })
    if #parts >= 2 then
      result = stringdelimiter(parts[#parts - 1], 15) .. "/" .. stringdelimiter(parts[#parts], 18)
    else
      result = stringdelimiter(rel, 18)
    end
  end

  return result
end

local tabline_filename_block = {
  init = function(self)
    self.filename = display_name(self.bufnr)
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
  { provider = "%-1(" },
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
  tabline_file_flags,
  { provider = " " },
}

local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

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

    if vim.bo[bufnr].filetype == "snacks_layout_box" then
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
  { provider = "", hl = { fg = "gray" } }, -- left truncation
  { provider = "", hl = { fg = "gray" } }, -- right trunctation
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
