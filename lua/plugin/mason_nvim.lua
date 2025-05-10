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

    vim.diagnostic.config({
      -- virtual_text = true,
      virtual_lines = {
        current_line = true
      },
    })

    local lsp_servers = {
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

    local linters_formatters = {
      'asmfmt',
      'prettier',
      'shellcheck',
      'checkmake'
    }

    -- :help vim.diagnostic.*
    km(
      'n',
      '<Leader>d',
      function()
        diagnostic.open_float({ max_width = 90 })
      end,
      { desc = 'Show diagnostics in a floating window (LSP)' }
    )
    km(
      'n',
      '[d',
      function()
        diagnostic.jump({ count = -1, float = false })
      end,
      { desc = 'Move to the previous diagnostic in the current buffer (LSP)' }
    )
    km(
      'n',
      ']d',
      function()
        diagnostic.jump({ count = 1, float = false })
      end,
      { desc = 'Move to the next diagnostic in the current buffer (LSP)' }
    )
    km(
      'n',
      '<Leader>q',
      diagnostic.setloclist,
      { desc = 'Add buffer diagnostics to the location list (LSP)' }
    )

    local function buf_format()
      lspbuf.format({ async = true })
    end

    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      api.nvim_set_option_value('omnifunc', "v:lua.vim.lsp.omnifunc", { buf = bufnr })

      -- :help vim.lsp.buf.*
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
        function()
          lspbuf.hover({ max_width = 90 })
        end,
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
        function()
          lspbuf.signature_help({ max_width = 90 })
        end,
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
    end

    local fn_default_capabilities = require("cmp_nvim_lsp").default_capabilities
    -- local fn_default_capabilities = require('blink.cmp').get_lsp_capabilities

    require("mason-lock").setup()

    require("lspconfig")

    vim.lsp.config('*', {
      capabilities = fn_default_capabilities(),
      on_attach = on_attach,
    })

    vim.lsp.config('lua_ls', {
      capabilities = fn_default_capabilities(),
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
    })

    vim.lsp.config('jsonls', {
      capabilities = fn_default_capabilities(),
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config('ts_ls', {
      capabilities = fn_default_capabilities(),
      on_attach = function(client, bufnr)
        local server_capabilities                           = client.server_capabilities

        server_capabilities.documentFormattingProvider      = false
        server_capabilities.documentRangeFormattingProvider = false

        on_attach(client, bufnr)
      end
    })

    local ts_ls_capabilities = fn_default_capabilities()

    ts_ls_capabilities.offsetEncoding = { "utf-16" }

    vim.lsp.config('ts_ls', {
      capabilities = ts_ls_capabilities,
      on_attach = on_attach,
    })

    require("mason").setup()

    require("mason-lspconfig").setup({ ensure_installed = lsp_servers })

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
      end,
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
    'b0o/schemastore.nvim',
    'jayp0521/mason-null-ls.nvim',
    'lewis6991/gitsigns.nvim',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls.nvim',
    'williamboman/mason-lspconfig.nvim',
    'zapling/mason-lock.nvim',
  }
}

return M
