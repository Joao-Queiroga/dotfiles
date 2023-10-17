local rt = require("rust-tools")
local handlers = require("plugins.lsp.handlers")

rt.setup({
	inlay_hints = {
		auto = false,
	},
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

			handlers.on_attach(_, bufnr)
		end,
		capabilities = handlers.capabilities,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = true,
				check = {
					enable = true,
					command = "clippy",
					features = "all",
				},
			},
		},
	},
})
