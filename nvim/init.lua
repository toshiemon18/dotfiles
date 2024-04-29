-- set mapleader
vim.g.mapleader = ' '

-- basic configs
require("configs.options")

-- keybinds
require("configs.keymaps")

-- bootstrap for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  require('configs.plugins.gruvbox.lazyspec'),
  require('configs.plugins.gitsigns.lazyspec'),
}

require("lazy").setup(plugins, {
  performance = {
    rtp = {
      disabled_plugins = {
      },
    },
  },
})
