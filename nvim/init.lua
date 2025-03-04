-- set mapleader
vim.g.mapleader = ' '

-- basic configs
require("configs.options")

-- keybinds
require("configs.keymaps")

-- obsidian settings
require('configs.plugins.obsidian')

-- bootstrap for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  require('configs.plugins.emmet'),
  require('configs.plugins.gruvbox'),
  require('configs.plugins.neogit'),
  require('configs.plugins.gitsigns'),
  require('configs.plugins.nvim_tree'),
  require('configs.plugins.telescope'),
  require('configs.plugins.completion'),
  require('configs.plugins.snippets'),
  require('configs.plugins.treesitter'),
  require('configs.plugins.render_markdown'),
  require('configs.plugins.surround'),
  require('configs.plugins.schamastore'),
  require('configs.plugins.lualine'),
  require('configs.plugins.language_server'),
  require("configs.plugins.lsp_saga"),
  require("configs.plugins.flutter")
}

require("lazy").setup(plugins, {
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
      },
    },
  },
})

vim.opt.filetype = "on"
vim.opt.filetype.indent = "on"
vim.opt.filetype.plugin = "on"
vim.opt.syntax = "on"

-- vim help を開くと、パーサプロバイダがないとtreesitterがエラーになる
-- ref: https://zenn.dev/kawarimidoll/articles/18ee967072def7
vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
    pcall(wrapped, bufnr, lang)
  end
end)(vim.treesitter.start)

