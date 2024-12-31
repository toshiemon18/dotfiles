local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip",                       dependencies = { "afamadriz/friendly-snippets" } },
    { "saadparwaiz1/cmp_luasnip" },
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
  },
  config = function()
    -- -------------------------
    -- nvim-cmp の設定
    -- nvim-cmp 自体はLSP, Snippet候補を出す機能はないので、そのための設定を書く
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert"
      },
      -- LuaSnip プラグインで言語ごとのスニペットを補完メニューに含める
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      ghost_text = { enabled = true },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<TAB>"] = cmp.mapping.confirm({ select = true }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "buffer",  keyword_length = 5, max_item_count = 5 },
        { name = "path" },
        { name = "luasnip" },
      }),
      formatting = {
        fields = { cmp.ItemField.Menu, cmp.ItemField.Abbr, cmp.ItemField.Kind },
      },
      experimental = { native_menu = false, ghost_text = { enabled = true } },
    })

    -- -------------------------
    -- nvim-lspconfig の設定
    -- 言語のLSPやFormatter ごとの設定を作る
    local lsp_util = require('lspconfig.util')
    local lspconfig = require('lspconfig')
    require('lspconfig.ui.windows').default_options.border = 'single'

    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local function make_conf(...)
      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      lsp_capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
      lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits", "documentHighlight" },
      }
      lsp_capabilities.textDocument.colorProvider = { dynamicRegistration = false }
      lsp_capabilities = cmp_nvim_lsp.default_capabilities(lsp_capabilities)

      return vim.tbl_deep_extend("force", {
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
          ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
          }),
        },
        capabilities = lsp_capabilities,
      }, ...)
    end

    -- Lua
    -- lua-ls
    lspconfig.lua_ls.setup(make_conf({
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
          runtime = {
            -- LuaJIT in the case of Neovim
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
            pathStrict = true
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = 'space',
              indent_size = '2'
            }
          }
        },
      },
    }))

    -- Ruby
    -- ruby-lsp
    lspconfig.ruby_lsp.setup(make_conf({
      settings = {
        formatter = "standard",
        linter = "standard",
      }
    }))

    -- CSS
    -- tailwindcss
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      root_dir = lsp_util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts"
      ),
    })

    -- Json
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    -- yaml
    lspconfig.yamlls.setup({
      capabilities = capabilities,
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    })

    -- typescript/javascript/jsx/tsx
    -- ref: https://github.com/neovim/nvim-lspconfig/blob/8b15a1a597a59f4f5306fad9adfe99454feab743/doc/configs.md#ts_ls
    lspconfig.ts_ls.setup({
      on_attach = function(client)
        if not lspconfig.util.root_pattern("package.json")(vim.fn.getcwd()) then
          client.stop(true)
        end
      end
    })

    -- keybinds
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- TODO: move this to typescript
        vim.cmd([[command! OR lua lsp_organize_imports()]])

        local opts = { noremap = true, silent = true }
        local function lsp_show_diagnostics()
          -- vim.diagnostic.open_float({ border = border })
          vim.diagnostic.open_float()
        end
        -- lsp diagnoticses
        vim.keymap.set("n", "<leader>aa", lsp_show_diagnostics, opts)
        vim.keymap.set("n", "gl", lsp_show_diagnostics, opts)
        vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
        vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
        vim.keymap.set("n", "<leader>aq", vim.diagnostic.setloclist, opts)

        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        -- vim.keymap.set("n", "gO", lsp_organize_imports, bufopts)
        vim.keymap.set("n", "gf", function()
          vim.lsp.buf.format({ async = true })
        end)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", bufopts)
        vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
        vim.keymap.set("n", "S", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", bufopts)

        -- FIXME the following keymaps are not working when using a autocmd to set up
        -- vim.keymap.set("x", "gA", vim.lsp.buf.range_code_action, bufopts)
        -- vim.keymap.set("n", "<C-x><C-x>", vim.lsp.buf.signature_help, bufopts)

        -- set up mousemenu options for lsp
        vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>Telescope lsp_definitions<cr>]])
        vim.cmd([[:amenu 10.110 mousemenu.References <cmd>Telescope lsp_references<cr>]])
        vim.cmd([[:amenu 10.120 mousemenu.Implementation <cmd>Telescope lsp_implementations<cr>]])

        vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<cr>")
      end,
    })
  end
}
