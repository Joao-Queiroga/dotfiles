local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

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

-- which key
local wk = require("which-key")
local presets = require("which-key.plugins.presets")
presets.operators["v"] = nil

local leader_mappings = {
	f = {
		name = "Files",
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
	},
	l = {
		name = "Lsp",
		a = { vim.lsp.buf.code_action, "Code actions" },
		r = { vim.lsp.buf.rename, "Rename" },
	},
	g = {
		name = "Git",
		n = { "<cmd>Neogit<cr>", "Neogit" },
	},
	y = {
		name = "Yadm",
		n = {
			function()
				vim.env.GIT_DIR = vim.fn.expand("~/.local/share/yadm/repo.git")
				vim.env.GIT_WORK_TREE = vim.fn.expand("~")
				require("neogit").open()
			end,
			"Neogit yadm",
		},
		a = {
			function()
				os.execute("yadm add " .. vim.api.nvim_buf_get_name(0))
			end,
			"Add current file",
		},
	},
	t = {
		name = "Table Mode",
		m = "Toggle",
		t = "Tableize",
		r = "Realign",
		s = "Sort",
		i = {
			name = "Insert Column",
			c = "After",
			C = "Before",
		},
		d = {
			name = "Delete",
			c = "Column",
			d = "Row",
		},
		f = {
			name = "Formula",
			a = "Add",
			e = "Eval",
		},
	},
	o = {
		name = "Org-Mode",
		a = "Org agenda",
		c = "Org capture",
	},
	C = {
		name = "ChatGPT",
	},
	d = {
		name = "Debug",
		t = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle UI" },
		b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint" },
		c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
		r = { "<cmd>lua require('dapui').open({ reset = true })<CR>", "Reset UI" },
	},
}

wk.register(leader_mappings, { prefix = "<leader>", mode = { "n", "v" } })
