local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local mason = require("mason")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
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

local M = {}

local function lsp_organize_imports()
  local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
  vim.lsp.buf.execute_command(params)
end

local function lsp_show_diagnostics()
  vim.diagnostic.open_float({ border = border })
end

-- _G makes this function available to vimscript lua calls
_G.lsp_organize_imports = lsp_organize_imports

local function make_conf(...)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits", "documentHighlight" },
  }
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  return vim.tbl_deep_extend("force", {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
      }),
    },
    capabilities = capabilities,
  }, ...)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- TODO: move this to typescript
    vim.cmd([[command! OR lua lsp_organize_imports()]])

    local opts = { noremap = true, silent = true }
    -- lsp diagnoticses
    vim.keymap.set("n", "<leader>aa", lsp_show_diagnostics, opts)
    vim.keymap.set("n", "gl", lsp_show_diagnostics, opts)
    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    vim.keymap.set("n", "<leader>aq", vim.diagnostic.setloclist, opts)

    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gO", lsp_organize_imports, bufopts)
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

function M.setup()
  mason.setup({ ui = { border = border } })

  mason_lspconfig.setup({
    ensure_installed = {
      -- javascript/typescript
      "eslint",
      "tsserver",
      "astro",
      -- lua
      "lua_ls",
      -- css/tailwindcss
      "tailwindcss",
      -- json
      "jsonls",
      -- vimscript
      "vimls",
      -- Ruby
      "ruby_lsp",    -- LSP
      "standardrb",  -- Formatter
    },
    automatic_installation = true,
    ui = { check_outdated_servers_on_open = true },
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup(make_conf({}))
    end,

    lua_ls = function()
      lspconfig.lua_ls.setup(make_conf({
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            runtime = {
              -- LuaJIT in the case of Neovim
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      }))
    end,

    diagnosticls = function()
      lspconfig.diagnosticls.setup(make_conf({
        settings = {
          filetypes = { "sh" },
          init_options = {
            linters = {
              shellcheck = {
                sourceName = "shellcheck",
                command = "shellcheck",
                debounce = 100,
                args = { "--format=gcc", "-" },
                offsetLine = 0,
                offsetColumn = 0,
                formatLines = 1,
                formatPattern = {
                  "^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
                  { line = 1, column = 2, message = 4, security = 3 },
                },
                securities = { error = "error", warning = "warning", note = "info" },
              },
            },
            filetypes = { sh = "shellcheck" },
          },
        },
      }))
    end,
  })
end

return M
