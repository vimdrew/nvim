vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
})
