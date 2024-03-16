local jdtls = require("jdtls")
local handlers = require("plugins.lsp.handlers")

local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = { "jdtls" },
	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	on_attach = function(client, bufnr)
		handlers.on_attach(client, bufnr)
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
	capabilities = handlers.capabilities,

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {
			vim.fn.glob(
				vim.fn.stdpath("data")
					.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
			),
		},
	},
}

-- Add java-test to the list of bundles
vim.list_extend(
	config.init_options.bundles,
	vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", 1), "\n")
)

jdtls.start_or_attach(config)
vim.cmd([[
  command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
  command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
  command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
  command! -buffer JdtJol lua require('jdtls').jol()
  command! -buffer JdtBytecode lua require('jdtls').javap()
  command! -buffer JdtJshell lua require('jdtls').jshell()
  command! -buffer JdtTestsGenerate lua require('jdtls.tests').generate()
  command! -buffer JdtTesteGotoSubjects lua require('jdtls.tests').goto_subjects()
]])
