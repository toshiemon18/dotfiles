return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  init = function()
    vim.opt.bg = "dark"
  end,
  config = function()
    require("gruvbox").setup({
      overrides = {
        TabLineFill = { link = "Normal" },
        SignColumn = { link = "Normal" },
        NormalFloat = { link = "Normal" },

        GruvboxRedSign = { link = "GruvboxRed" },
        GruvboxGreenSign = { link = "GruvboxGreen" },
        GruvboxYellowSign = { link = "GruvboxYellow" },
        GruvboxBlueSign = { link = "GruvboxBlue" },
        GruvboxPurpleSign = { link = "GruvboxPurple" },
        GruvboxAquaSign = { link = "GruvboxAqua" },
        GruvboxOrangeSign = { link = "GruvboxOrange" },

        TroubleFoldIcon = { link = "Normal" },
        TroubleCount = { link = "GruvboxOrange", reverse = true },
      },
    })

    vim.cmd("colorscheme gruvbox")
  end,
}

