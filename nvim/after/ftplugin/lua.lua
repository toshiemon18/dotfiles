-- Lua

-- インデント設定
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

-- フォーマット設定
vim.opt_local.formatoptions:remove("t")
vim.opt_local.formatoptions:append("croqnlj")

-- 補完設定
vim.opt_local.completeopt:append("menu")
vim.opt_local.completeopt:append("menuone")
vim.opt_local.completeopt:append("noselect")

-- シンタックスハイライト設定
vim.opt_local.syntax = "lua"

