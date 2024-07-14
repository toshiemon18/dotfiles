return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      'nvimdev/lspsaga.nvim',
      config = function()
        require('lspsaga').setup({
          lightbulb = {
            enable = true,
          }
        })
      end,
      dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'nvim-tree/nvim-web-devicons',
      }
    }
  },
  config = function()
    require("configs.plugins.lsp.config").setup()
  end,
}
