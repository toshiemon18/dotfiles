local func = require "func"
-- Ruby

-- Rubyのbool値を返すメソッド名を判定できるようにする
vim.opt.iskeyword:append("?")

-- Indent
vim.bo.cindent = false
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.api.nvim_create_augroup("RSpec", {})
vim.api.nvim_create_autocmd({"BufWinEnter", "BufNewFile"}, {
  patern = { "*_spec.rb" },
  command = "set filetype=ruby.rspec"
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = { "Rakefile", "Schemafile" },
  callback = "set filetype=ruby"
})
