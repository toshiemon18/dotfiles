return {
  'tanvirtin/vgit.nvim',
  branch = 'v1.0.2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  config = function()
    local vgit = require("vgit")
    vgit.setup({
      keymaps = {
        -- NOTE: vgit の推奨キーマップが他のプラグインと競合してしまうので整理しきるまで無効化, :lua から使うこと
        -- ['n <C-k>'] = function() vgit.hunk_up() end,
        -- ['n <C-j>'] = function() vgit.hunk_down() end,
        -- ['n <leader>gs'] = function() vgit.buffer_hunk_stage() end,
        -- ['n <leader>gr'] = function() vgit.buffer_hunk_reset() end,
        -- ['n <leader>gp'] = function() vgit.buffer_hunk_preview() end,
        -- ['n <leader>gb'] = function() vgit.buffer_blame_preview() end,
        -- ['n <leader>gf'] = function() vgit.buffer_diff_preview() end,
        -- ['n <leader>gh'] = function() vgit.buffer_history_preview() end,
        -- ['n <leader>gu'] = function() vgit.buffer_reset() end,
        -- ['n <leader>gd'] = function() vgit.project_diff_preview() end,
        -- ['n <leader>gx'] = function() vgit.toggle_diff_preference() end,
      }
    })
  end
}
