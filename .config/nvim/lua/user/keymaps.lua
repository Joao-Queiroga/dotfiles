local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<cmd>NavigatorLeft<cr>", opts)
keymap("n", "<C-j>", "<cmd>NavigatorDown<cr>", opts)
keymap("n", "<C-k>", "<cmd>NavigatorUp<cr>", opts)
keymap("n", "<C-l>", "<cmd>NavigatorRight<cr>", opts)

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

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-j>", "<cmd>NavigatorDown<cr>", term_opts)
keymap("t", "<C-h>", "<cmd>NavigatorLeft<cr>", term_opts)
keymap("t", "<C-k>", "<cmd>NavigatorUp<cr>", term_opts)
keymap("t", "<C-l>", "<cmd>NavigatorRight<cr>", term_opts)

-- Inc rename
vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, opts)

-- which key
local wk = require("which-key")
local presets = require("which-key.plugins.presets")
presets.operators["v"] = nil

local leader_mappings = {
	c = { "<cmd>lua MiniBufremove.delete()<cr>", "Delete buffer" },
	e = { "<cmd>Neotree toggle<cr>", "Toggle FileTree" },
	f = {
		name = "Files",
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
		b = { "<cmd>lua MiniFiles.open()<cr>", "File Browser" },
	},
	l = {
		name = "Lsp",
		a = { vim.lsp.buf.code_action, "Code actions" },
		r = { vim.lsp.buf.rename, "Rename" },
		o = { "<cmd>NavBuddy<cr>", "Outline" },
		t = {
			function()
				require("trouble").toggle()
			end,
			"Trouble",
		},
		w = {
			function()
				require("trouble").toggle("workspace_diagnostics")
			end,
			"Workspace Diagnostics",
		},
		d = {
			function()
				require("trouble").toggle("document_diagnostics")
			end,
			"Document Diagnostics",
		},
		q = {
			function()
				require("trouble").toggle("quickfix")
			end,
			"Quickfixes",
		},
		l = {
			function()
				require("trouble").toggle("loclist")
			end,
			"Loclist",
		},
		R = {
			function()
				require("trouble").toggle("lsp_references")
			end,
			"LSP References",
		},
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
		c = { ":ChatGPT<CR>", "ChatGPT" },
		e = { ":ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
		g = { ":ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
		t = { ":ChatGPTRun translate<CR>", "Translate" },
		k = { ":ChatGPTRun keywords<CR>", "Keywords" },
		d = { ":ChatGPTRun docstring<CR>", "Docstring" },
		a = { ":ChatGPTRun add_tests<CR>", "Add Tests" },
		o = { ":ChatGPTRun optimize_code<CR>", "Optimize Code" },
		s = { ":ChatGPTRun summarize<CR>", "Summarize" },
		f = { ":ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
		x = { ":ChatGPTRun explain_code<CR>", "Explain Code" },
		r = { ":ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
		l = { ":ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
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
