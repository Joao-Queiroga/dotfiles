return {
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
}
