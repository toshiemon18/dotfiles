return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  ft = {"markdown", "mdx"},
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      -- on insert mode, cursor line is not rendering, other lines are rendering
      render_modes = true,

      heading = {
        -- NOTE: ヘッダーのレンダリングが sign column に食い込むバグが解決しないため
        enabled = false,
        -- width = "block",
        -- sign = false,
        -- icons = {},
      },

      -- ref: https://eiji.page/blog/neovim-render-markdown-nvim/
      checkbox = {
        checked = { scope_highlight = "@markup.strikethrough" },
        custom = {
          -- デフォルトの`[-]`であるtodoは削除
          todo = { raw = "", rendered = "", highlight = "" },
          canceled = {
            raw = "[-]",
            rendered = "󱘹",
            scope_highlight = "@markup.strikethrough",
            highlight = "@markup.strikethrough"
          },
        },
      },

      code = {
        width = "block",
      },
    })
  end,
}
