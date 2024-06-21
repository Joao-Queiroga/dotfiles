require("java").setup({
	jdk = { auto_install = false },
})
require("plugins.lsp.handlers").default_handler("jdtls")
