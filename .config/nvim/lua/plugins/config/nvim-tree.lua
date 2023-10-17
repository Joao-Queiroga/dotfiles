local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')

	local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr) --use default_on_attach

	vim.keymap.set('n', 'l',  api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'h',  api.node.navigate.parent_close,        opts('Close Directory'))
end

return {
	hijack_cursor = true,
	hijack_netrw = false,
	on_attach = my_on_attach,
	renderer = {
		indent_markers = {
			enable = true,
			inline_arrows = false
		},
		icons = {
			show = {
				folder_arrow = false
			}
		}
	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true
	},
}
