local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
	return
end

local handlers = require("plugins.lsp.handlers")
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

local config = {
	cmd = {

		-- 💀
		"java",

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		vim.fn.expand(mason_path .. "jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

		-- 💀
		"-configuration",
		mason_path .. "jdtls/config_linux",

		"-data",
		workspace_dir,
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

	settings = {
		java = {},
	},

	on_attach = function(client, bufnr)
		handlers.on_attach(client, bufnr)
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
	capabilities = handlers.capabilities,

	-- add java dap to list of bundles
	init_options = {
		bundles = {
			vim.fn.expand(mason_path .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
		},
	},
}

-- Add java-test to the list of bundles
vim.list_extend(
	config.init_options.bundles,
	vim.split(vim.fn.glob(mason_path .. "java-test/extension/server/*.jar", 1), "\n")
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
