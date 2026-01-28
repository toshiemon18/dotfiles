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
opts.conceallevel = 2
opts.mouse = 'h'
opts.mousehide = true
opts.autowrite = true
opts.updatetime = 300
opts.ambiwidth = 'single'

-- autocmds
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- 通常のファイルバッファのみ自動保存
local function is_normal_buffer()
  return vim.fn.expand('%') ~= ''
    and vim.bo.modifiable
    and not vim.bo.readonly
    and vim.bo.buftype == ''
end

autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    if is_normal_buffer() then
      vim.cmd('silent! update')
    end
  end
})
autocmd("CursorHoldI", {
  pattern = "*",
  callback = function()
    if is_normal_buffer() then
      vim.cmd('silent! update')
    end
  end
})

-- appearance
opts.cmdheight = 1
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

local function format_json_buffer()
  vim.cmd([[%!jq .]])
end

function format_json_visual()
  vim.cmd([['<,'>!jq .]])
end

vim.api.nvim_create_user_command('Jqf', format_json_buffer, {})
vim.api.nvim_create_user_command('Jqfv', format_json_visual, { range = true })


