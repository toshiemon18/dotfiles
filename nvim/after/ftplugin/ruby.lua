-- Ruby

-- インデント設定
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

-- メソッド名の?をキーワードとして認識
vim.opt_local.iskeyword:append("?")

-- インデントキーの設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.indentkeys:remove(".")
  end
})

-- RSpecファイルの設定
vim.api.nvim_create_autocmd({"BufWinEnter", "BufNewFile"}, {
  pattern = "*_spec.rb",
  callback = function()
    vim.bo.filetype = "ruby.rspec"
  end
})

-- RakefileとSchemafileの設定
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"Rakefile", "Schemafile"},
  callback = function()
    vim.bo.filetype = "ruby"
  end
})

