local autocmd = vim.api.nvim_create_autocmd

-- open .h files as C instead of C++
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h",
  callback = function()
    vim.bo.filetype = "c"
  end,
})

-- change cwd when editing a config file
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = vim.fn.expand("~/.config/*/*", true, true),
  callback = function()
    vim.cmd("cd " .. vim.fn.expand("%:p:h"))
  end,
})

autocmd("Filetype", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
