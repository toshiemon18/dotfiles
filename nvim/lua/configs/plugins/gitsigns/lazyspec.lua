return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = "▐" },
        change = { hl = "GitSignsChange", text = "▐" },
        delete = { hl = "GitSignsDelete", text = "▐" },
        topdelete = { hl = "GitSignsDelete", text = "▐" },
        changedelete = { hl = "GitSignsChange", text = "▐" },
        untracked = { hl = "GitSignsAdd", text = "▐" },
      },
    })

    local opts = { noremap = true }
    vim.keymap.set('n', ']g', '<Cmd>Gitsigns next_hunk<Cr>', opts)
    vim.keymap.set('n', '[g', '<Cmd>Gitsigns prev_hunk<Cr>', opts)
    vim.keymap.set('n', '<C-g><C-p>', '<Cmd>Gitsigns preview_hunk<Cr>', opts)
    vim.keymap.set('n', '<C-g><C-v>', '<Cmd>Gitsigns blame_line<Cr>', opts)
    vim.keymap.set('n', '<C-g>a', '<Cmd>Gitsigns stage_buffer<Cr>', opts)
  end,
}
