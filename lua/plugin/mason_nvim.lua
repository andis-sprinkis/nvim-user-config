local sys_reqr = vim.g.sys_reqr

local M = {
  'williamboman/mason.nvim',
  cond = sys_reqr.lsp_plugins,
  enabled = sys_reqr.lsp_plugins,
  config = function()
    local diagnostic = vim.diagnostic
    local lsp = vim.lsp
    local api = vim.api
    local lspbuf = lsp.buf
    local km = vim.keymap.set

    local lsp_servers = {
      'asm_lsp',
      'awk_ls',
      'bashls',
      'clangd',
      'cssls',
      'dockerls',
      'eslint',
      'html',
      'jsonls',
      'lua_ls',
      -- 'pylsp',
      'ruff',
      'stylelint_lsp',
      'texlab',
      'ts_ls',
      'yamlls',
    }

    if sys_reqr.lsp_neocmake then
      table.insert(lsp_servers, 'neocmake')
    end

    if sys_reqr.lsp_asm then
      table.insert(lsp_servers, 'asm_lsp')
    end

    local dap_providers = {
      -- 'codelldb',
      -- 'python',
    }

    local linters_formatters = {
      'asmfmt',
      'prettier',
      'shellcheck',
      'checkmake'
    }

    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    km(
      'n',
      '<Leader>d',
      diagnostic.open_float,
      { desc = 'Show diagnostics in a floating window (LSP)' }
    )
    km(
      'n',
      '[d',
      diagnostic.goto_prev,
      { desc = 'Move to the previous diagnostic in the current buffer (LSP)' }
    )
    km(
      'n',
      ']d',
      diagnostic.goto_next,
      { desc = 'Move to the next diagnostic in the current buffer (LSP)' }
    )
    km(
      'n',
      '<Leader>q',
      diagnostic.setloclist,
      { desc = 'Add buffer diagnostics to the location list (LSP)' }
    )

    local workspace_diagnostics = require("workspace-diagnostics")

    km(
      'n',
      '<Leader>x',
      function()
        for _, client in ipairs(vim.lsp.buf_get_clients()) do
          workspace_diagnostics.populate_workspace_diagnostics(client, 0)
        end
      end,
      { desc = 'Display the workspace diagnostics (LSP, workspace-diagnostics)' }
    )

    local function buf_format() lspbuf.format({ async = true }) end

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      km(
        'n',
        'gD',
        lspbuf.declaration,
        { buffer = bufnr, desc = 'Jump to the declaration of the symbol under the cursor (LSP)' }
      )
      km(
        'n',
        'gd',
        lspbuf.definition,
        { buffer = bufnr, desc = 'Jump to the definition of the symbol under the cursor (LSP)' }
      )
      km(
        { 'n', 'x' },
        'K',
        lspbuf.hover,
        { buffer = bufnr, desc = 'Display hover information about the symbol under the cursor (LSP)' }
      )
      km(
        'n',
        'gi',
        lspbuf.implementation,
        { buffer = bufnr, desc = 'List all the implementations for the symbol under the cursor (LSP)' }
      )
      km(
        'n',
        '<C-s>',
        lspbuf.signature_help,
        { buffer = bufnr, desc = 'Displays signature information about the symbol under the cursor (LSP)' }
      )
      -- km(
      --   'n',
      --   '<Leader>wa',
      --   lspbuf.add_workspace_folder,
      --   { buffer = bufnr, desc = 'Add the folder at path to the workspace folders (LSP)' }
      -- )
      -- km(
      --   'n',
      --   '<Leader>wr',
      --   lspbuf.remove_workspace_folder,
      --   { buffer = bufnr, desc = 'Remove the folder at path from the workspace folders (LSP)' }
      -- )
      -- km(
      --   'n',
      --   '<Leader>wl',
      --   function() print(vim.inspect(lspbuf.list_workspace_folders())) end,
      --   { buffer = bufnr, desc = 'List workspace folders (LSP)' }
      -- )
      km(
        'n',
        '<Leader>D',
        lspbuf.type_definition,
        { buffer = bufnr, desc = 'Jump to the definition of the type of the symbol under the cursor (LSP)' }
      )
      km(
        'n',
        '<Leader>rn',
        lspbuf.rename,
        { buffer = bufnr, desc = 'Rename all references to the symbol under the cursor (LSP)' }
      )
      km(
        'n',
        '<Leader>ca',
        lspbuf.code_action,
        { buffer = bufnr, desc = 'Select a code action available at the current cursor position (LSP)' }
      )
      km(
        'n',
        'gr',
        lspbuf.references,
        { buffer = bufnr, desc = 'List all the references to the symbol under the cursor (LSP)' }
      )

      local server_capabilities = client.server_capabilities

      if server_capabilities.documentFormattingProvider then
        km(
          'n',
          '<Leader>f',
          buf_format,
          { buffer = bufnr, desc = 'Format a buffer using the attached LSP (LSP)' }
        )
      end

      if server_capabilities.documentRangeFormattingProvider then
        km(
          'x',
          '<Leader>f',
          buf_format,
          { buffer = bufnr, desc = 'Format the range using the attached LSP (LSP)' }
        )
      end

      -- Disabling LSP highlights
      -- server_capabilities.semanticTokensProvider = nil

      workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
    end

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local function make_config()
      return {
        capabilities = cmp_nvim_lsp.default_capabilities(),
        on_attach = on_attach,
      }
    end

    require("mason-lock").setup()

    require("mason").setup()

    require("mason-lspconfig").setup({ ensure_installed = lsp_servers })

    local lspconfig = require("lspconfig")

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup(make_config())
      end,
      ["lua_ls"] = function()
        local config = make_config()

        config.settings = {
          Lua = {
            telemetry = {
              enable = false,
            },
          }
        }

        lspconfig.lua_ls.setup(config)
      end,
      ["jsonls"] = function()
        local config = make_config()

        config.settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        }

        lspconfig.jsonls.setup(config)
      end,
      ["ts_ls"] = function()
        local config = make_config()

        config.on_attach = function(client, bufnr)
          local server_capabilities                           = client.server_capabilities

          server_capabilities.documentFormattingProvider      = false
          server_capabilities.documentRangeFormattingProvider = false

          on_attach(client, bufnr)
        end

        lspconfig.ts_ls.setup(config)
      end,
      ["clangd"] = function()
        local config = make_config()

        config.capabilities.offsetEncoding = { "utf-16" }

        lspconfig.clangd.setup(config)
      end
    })

    require('mason-null-ls').setup({ ensure_installed = linters_formatters })

    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.asmfmt,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.code_actions.gitsigns,
      },
      on_attach = function(client, bufnr)
        local server_capabilities = client.server_capabilities

        if server_capabilities.documentFormattingProvider then
          km(
            'n',
            '<Leader>f',
            buf_format,
            { buffer = bufnr, desc = 'Format a buffer using the attached LSP (null-ls)' }
          )
        end

        if server_capabilities.documentRangeFormattingProvider then
          km(
            'x',
            '<Leader>f',
            buf_format,
            { buffer = bufnr, desc = 'Format a buffer using the attached LSP (null-ls)' }
          )
        end

        workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
      end,
    })

    require('mason-nvim-dap').setup({
      automatic_setup = true,
      ensure_installed = dap_providers
    })

    -- vim.api.nvim_create_autocmd('LspAttach', {
    --   callback = function()
    --     if vim.b.large_file_buf then
    --       vim.defer_fn(function()
    --         vim.cmd [[LspStop]]
    --         vim.notify(
    --           "LSP clients for the buffer were stopped because it is large."
    --         )
    --       end, 10)
    --     end
    --   end
    -- })
  end,
  dependencies = {
    'RRethy/vim-illuminate',
    'artemave/workspace-diagnostics.nvim',
    'b0o/schemastore.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'jayp0521/mason-null-ls.nvim',
    'lewis6991/gitsigns.nvim',
    'mfussenegger/nvim-dap',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls.nvim',
    'williamboman/mason-lspconfig.nvim',
    'zapling/mason-lock.nvim',
  }
}

return M
