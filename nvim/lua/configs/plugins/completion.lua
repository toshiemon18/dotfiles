local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 30
local MIN_LABEL_WIDTH = 15

-- 補完候補のメニューを整形するための関数
-- menu は非表示にする
-- 補完候補は最大30文字、最低でも15文字分の幅までは確保する
local function completion_candidates_formatter(entry, vim_item)
  local label = vim_item.abbr
  local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

  -- vim_item.menu = ""

  if truncated_label ~= label then
    vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
  elseif string.len(label) < MIN_LABEL_WIDTH then
    local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
    vim_item.abbr = label .. padding
  end

  return vim_item
end

local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

return {
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        build = vim.fn.has "win32" ~= 0 and "make install_jsregexp" or nil,
        dependencies = {
          "rafamadriz/friendly-snippets",
          "benfowler/telescope-luasnip.nvim",
        },
        config = function(_, opts)
          if opts then require("luasnip").config.setup(opts) end
          vim.tbl_map(
            function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
            { "vscode", "snipmate", "lua" }
          )
          -- friendly-snippets - enable standardized comments snippets
          require("luasnip").filetype_extend("typescript", { "tsdoc" })
          require("luasnip").filetype_extend("javascript", { "jsdoc" })
          require("luasnip").filetype_extend("lua", { "luadoc" })
          require("luasnip").filetype_extend("python", { "pydoc" })
          require("luasnip").filetype_extend("ruby", { "rdoc" })
          require("luasnip").filetype_extend("ruby", { "rails" })
          require("luasnip").filetype_extend("sh", { "shelldoc" })
        end,
      },
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local cmp = require("cmp")

      vim.o.completeopt = "menu,menuone,noselect"

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<TAB>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = "path" },
          { name = "nvim_lua" },
          { name = "nvim_lsp", priority = 100 },
          { name = "luasnip" },
          -- { name = "buffer", priority = 999, keyword_length = 3, max_item_count = 5 },
        }),
        formatting = {
          -- fields = {
          --   cmp.ItemField.Menu,
          --   cmp.ItemField.Abbr,
          --   cmp.ItemField.Kind
          -- },
          -- format = completion_candidates_formatter
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
            })[entry.source.name]
            return vim_item
          end
        },
        experimental = { native_menu = false, ghost_text = { enabled = true } },
      })
    end,
  },
}
