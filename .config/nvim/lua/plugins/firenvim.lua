---@type LazySpec[]
return {
	"glacambre/firenvim",
	cond = not not vim.g.started_by_firenvim,
	build = function()
		vim.fn["firenvim#install"](0)
	end,
}
