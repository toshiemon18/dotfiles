return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      theme = "lotus"
    })

    vim.cmd("colorscheme kanagawa")
  end
}
