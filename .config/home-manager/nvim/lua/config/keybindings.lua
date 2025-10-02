local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap("n", "<leader>e", function()
  Snacks.explorer()
end, opts)

-- Navigate in visual lines
keymap({ "n", "v", "x" }, "j", "gj", opts)
keymap({ "n", "v", "x" }, "k", "gk", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

-- Yadm
keymap("n", "<leader>ya", function()
  os.execute("yadm add " .. vim.api.nvim_buf_get_name(0))
end, { desc = "Add current file" })

-- Snippets
keymap({ "i", "s" }, "<Tab>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<cmd>lua vim.snippet.jump(1)<cr>"
  else
    return "<Tab>"
  end
end, { expr = true })
keymap({ "i", "s" }, "<S-Tab>", function()
  if vim.snippet.active({ direction = -1 }) then
    return "<cmd>lua vim.snippet.jump(-1)<cr>"
  else
    return "<S-Tab>"
  end
end, { expr = true })
