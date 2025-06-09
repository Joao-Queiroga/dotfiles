return {
  cmd = { vim.fn.executable("qmlls") == 1 and "qmlls" or "/usr/lib64/qt6/bin/qmlls", "-E" },
}
