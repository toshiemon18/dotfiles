return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function ()
    require("lspsaga").setup({
      lightbulb = {
        enable = true
      },
      breadcrumbs = {
        enable = true
      }
    })
  end
}