return {
--[[ 	settings = {
		python = {
			analysis = {
				diagnosticMode = 'workspace',
				extraPaths = {
					vim.fn.expand("/run/current-system/sw/lib/python3.*/site-packages")
				}
			}
		}
	} ]]
}
