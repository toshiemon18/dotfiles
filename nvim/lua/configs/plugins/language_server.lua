local function setup_mason()
  local mason = require("mason")

  mason.setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗'
      }
    }
  })

  vim.cmd([[
    hi DiagnosticDefaultError ctermfg=red guifg=#D54E53
    hi DiagnosticVirtualTextError ctermfg=red  guifg=#D54E53

    hi DiagnosticDefaultWarn ctermfg=yellow guifg=#E7C547
    hi DiagnosticVirtualTextWarn ctermfg=yellow guifg=#E7C547

    hi DiagnosticDefaultInfo ctermfg=white guifg=#EAEAEA
    hi DiagnosticVirtualTextInfo ctermfg=white guifg=#EAEAEA

    hi DiagnosticDefaultHint ctermfg=blue guifg=#7AA6DA
    hi DiagnosticVirtualTextHint ctermfg=blue guifg=#7AA6DA
  ]])
  -- remove diagnostic signs and only color numbers vim.fn.sign_define('DiagnosticSignError', { text = '', numhl = 'DiagnosticDefaultError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '', numhl = 'DiagnosticDefaultWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = '', numhl = 'DiagnosticDefaultInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '', numhl = 'DiagnosticDefaultHint' })
end

local function setup_lspconfig()
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({
    ensure_installed = {},
    automatic_installation = true
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
      "documentHighlight"
    },
  }
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }

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

  local function on_attach(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- LSP Keymap configs
    -- * Diagnostic keymaps
    vim.keymap.set("n", "<leader>aa", vim.diagnostic.open_float, bufopts)
    vim.keymap.set("n", "dl", vim.diagnostic.setloclist, bufopts)

    -- definition/references (Telescope)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
    vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<CR>", bufopts)

    -- type definition & declaration
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)

    -- signature help
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, bufopts)

    -- formatting
    vim.keymap.set('n', '<space>gf', vim.lsp.buf.format, bufopts)

    -- Note: K (hover), gh (finder), gp (peek), [d/]d (diagnostics) は lsp_saga で定義
  end

  local function make_conf(...)
    return vim.tbl_deep_extend("force", {
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.handlers["textDocument/publishDiagnostics"],
          { virtual_text = true }
        ),
      },
      capabilities = capabilities
    }, ...)
  end

  local lspconfig = require("lspconfig")
  mason_lspconfig.setup({
    function(server_name)
      lspconfig[server_name].setup(make_conf({
        on_attach = on_attach
      }))
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup(make_conf({
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false }
          }
        }
      }))
    end,

    ["ruby_lsp"] = function()
      lspconfig.ruby_lsp.setup(make_conf({
        on_attach = on_attach,
        cmd = { "ruby-lsp" },
        settings = {
          formatter = "standard",
          linter = "standard"
        },
        filetypes = { "ruby" },
        root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
        single_file_support = true
      }))
    end,

    ["ts_ls"] = function()
      lspconfig.ts_ls.setup(make_conf({
        on_attach = on_attach,
        filetypes = {
          "typescript",
          "typescriptreact",
          "typescript.tsx"
        },
        root_dir = function(...)
          return lspconfig.util.root_pattern(".git")(...)
        end,
        cmd = { "typescript-language-server", "--stdio" }
      }))
    end,

    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        root_dir = function(...)
          return lspconfig.util.root_pattern(".git")(...)
        end
      })
    end,

    ["gopls"] = function()
      lspconfig.gopls.setup(make_conf({
        on_attach = on_attach
      }))
    end,

    ["jsonls"] = function() 
      lspconfig.jsonls.setup(make_conf({
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }))
    end,


    ["yamlls"] = function()
      lspconfig.yamlls.setup(make_conf({
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      }))
    end
  })
end

return {
  "mason-org/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "Mason", "MasonUpdate", "MasonInstall" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    {
      "mason-org/mason-lspconfig.nvim",
      lazy = true,
    },
    {
      "zapling/mason-lock.nvim",
      lazy = true,
      cmd = { "MasonLock", "MasonLockRestore" },
    },
    {
      "b0o/schemastore.nvim",
      ft = { "javascript", "typescript", "json", "yaml" }
    }
  },
  config = function()
    setup_mason()
    setup_lspconfig()

    -- mason-lock を遅延ロード
    require("mason-lock").setup({
      lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json"
    })
  end
}

