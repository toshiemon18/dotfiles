return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',     -- optional for vim.ui.select
  },
  config = true,
  ui = {
    border = "none",
  },
  dev_log = {
    enabled = false,
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
  },
}
