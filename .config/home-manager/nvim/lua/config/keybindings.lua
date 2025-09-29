local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap("n", "<leader>e", function() Snacks.explorer() end, opts)
