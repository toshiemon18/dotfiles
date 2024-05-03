return {
  "neogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",        -- 必須の依存先, git を非同期に実行する必要があるため
    "nvim-telescope/telescope.nvim" -- telescope で色々操作させたい
  },
  config = function()
    require("neogit").setup({})
  end
}

