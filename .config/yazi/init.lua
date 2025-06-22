require("starship"):setup()
require("full-border"):setup()
require("augment-command"):setup({
	default_item_group_for_prompt = "selected",
	preserve_file_permissions = true,
	smooth_scrolling = true,
})
require("git"):setup()
require("zoxide"):setup({
	update_db = true,
})
