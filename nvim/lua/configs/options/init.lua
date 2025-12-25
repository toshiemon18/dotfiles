-- general settings
local opts = vim.opt

opts.tabstop = 2
opts.backspace = 'indent,eol,start'
opts.hidden = true
opts.shiftwidth = 2
opts.textwidth = 70
opts.colorcolumn = '80'
opts.clipboard:append('unnamedplus')
opts.backup = false
opts.swapfile = false
opts.modifiable = true
opts.write = true
opts.undofile = true
opts.undodir = os.getenv('XDG_CONFIG_HOME') .. '/nvim/undodir'
opts.tw = 0
opts.conceallevel = 0
opts.mouse = 'h'
opts.mousehide = true
opts.autowrite = true
opts.updatetime = 300

-- autocmds
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    if vim.fn.expand('%') ~= '' then
      vim.cmd('silent! update')
    end
  end
})
autocmd("CursorHoldI", {
  pattern = "*",
  callback = function()
    if vim.fn.expand('%') ~= '' then
      vim.cmd('silent! update')
    end
  end
})

-- appearance
opts.cmdheight = 2
opts.title = true
opts.wildmenu = true
opts.wildmode = 'full'
opts.laststatus = 2
opts.showmatch = true
opts.showcmd = true
opts.ruler = true
opts.number = true
opts.cursorline = true
opts.cursorcolumn = true

-- note:
-- lspsaga.nvim の code actions feature が絵文字の幅を取るときUI全体がガクつく
-- 絵文字の幅確保を action があるか判定したあとに実行しているっぽい挙動だったので、
-- 事前に signcolumn を有効にして number 左側のスペースを確保しておく
vim.wo.signcolumn = "yes"
