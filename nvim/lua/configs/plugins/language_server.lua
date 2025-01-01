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
    properties = { "documentation", "detail", "additionalTextEdits", "documentHighlight" },
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
    local keymap_opts = {
      noremap = true,
      silent = true,
      buffer = bufnr
    }


    -- LSP Keymap configs
    -- * Diagnostic keymaps
    -- 診断をフロートウィンドウで表示する
    local function lsp_show_diagnostics()
      vim.diagnostic.open_float()
    end
    vim.keymap.set("n", "<leader>aa", lsp_show_diagnostics, keymap_opts)
    vim.keymap.set("n", "dl", vim.diagnostic.setloclist, keymap_opts)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- definition/references
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", keymap_opts)

    -- formatting
    vim.keymap.set('n', '<space>gf', vim.lsp.buf.format, bufopts)
  end

  local function make_conf(...)
    return vim.tbl_deep_extend("force", {
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
        }),
      },
      capabilities = capabilities
    }, ...)
  end

  local lspconfig = require("lspconfig")
  mason_lspconfig.setup_handlers({
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
            runtime = { version = "LaJIT" },
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
        settings = {
          formatter = "standard",
          linter = "standard"
        }
      }))
    end,
    ["ts_ls"] = function()
      lspconfig.tsserver.setup(make_conf({
        on_attach = on_attach,
        filetypes = {
          "typescript",
          "typescriptreact",
          "typescript.tsx"
        },
        cmd = { "typescript-language-server", "--stdio" }
      }))
    end,
    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup({})
    end
  })
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    {
      "williamboman/mason-lspconfig.nvim",
      event = { "BufReadPre", "BufNewFile" }
    },
    'hrsh7th/cmp-nvim-lsp',
    {
      "zapling/mason-lock.nvim",
      init = function()
        require("mason-lock").setup({
          lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json"
        })
      end
    }
  },
  config = function()
    setup_mason()
    setup_lspconfig()
  end
}
