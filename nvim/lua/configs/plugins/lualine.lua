return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-web-devicons", opt = true },
  event = { "BufNewFile", "BufRead" },
  options = { theme = "gruvbox" },
  config = function()
    local lualine = require("lualine")

    local diff_config = { "diff", symbols = { added = " ", modified = " ", removed = " " } }
    local diagnostics_config = { "diagnostics", sources = { "nvim_lsp" } }
    local filetype_config = { "filetype" }
    local filename_config = {
      "filename",
      newfile_status = true,
      symbols = {
        modified = " ",
        readonly = "󰌾 ",
      },
      path = 1
    }


    -- ref: https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#component-options
    local config = {
      options = {
        -- theme = custom_theme,
        component_separators = {},
        section_separators = {},
        disabled_filetypes = {
          statusline = { "no-neck-pain" },
          winbar = { "no-neck-pain" },
        },
      },
      winbar = {},
      inactive_winbar = {},
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { diff_config, diagnostics_config },
        lualine_x = { filetype_config, filename_config },
        lualine_y = { "encoding", "fileformat" },
        lualine_z = {},
      },
    }
    lualine.setup(config)
  end,
}
