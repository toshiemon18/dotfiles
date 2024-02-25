-- Ruby plugins

local autocmd = vim.api.nvim_create_autocmd

autocmd(
  "BufNewFile,BufRead",
  {
    pattern = "*.jbuilder",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(buf, "filetype", "ruby")
    end
  }
)

autocmd(
  "BufNewFile,BufRead",
  {
    pattern = "Schemafile",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(buf, "filetype", "ruby")
    end
  }
)

local opt = vim.opt
opt.iskeyword:append("?")
opt.indent = false
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2

