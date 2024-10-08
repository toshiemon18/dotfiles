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
    }


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
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
        },
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = { diff_config, diagnostics_config },
        lualine_x = { filetype_config, filename_config },
        lualine_y = { "encoding", "fileformat" },
        lualine_z = {},
      },
    }
    lualine.setup(config)
  end,
}
