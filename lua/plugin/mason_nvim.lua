local sys_reqr = vim.g.sys_reqr

local M = {
  'mason-org/mason.nvim',
  cond = sys_reqr.lsp_plugins,
  enabled = sys_reqr.lsp_plugins,
  config = function()
    local diagnostic = vim.diagnostic
    local lsp = vim.lsp
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
      'checkmake',
      -- 'cspell'
    }

    -- Default keymaps (doc/lsp.txt):
    -- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
    -- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
    -- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
    -- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
    -- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
    -- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
    -- |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or a custom keymap for `K` exists.

    km(
      'n',
      '<Leader>d',
      diagnostic.open_float,
      { desc = 'Show diagnostics in a floating window (LSP)' }
    )
    km(
      'n',
      'grP',
      function()
        diagnostic.jump({ count = -1, float = false })
      end,
      { desc = 'Move to the previous diagnostic in the current buffer (LSP)' }
    )
    km(
      'n',
      'grN',
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
      -- :help vim.lsp.buf.*
      km(
        'n',
        'grl',
        lspbuf.declaration,
        { buffer = bufnr, desc = 'Jump to the declaration of the symbol under the cursor (LSP)' }
      )
      km(
        'n',
        'grd',
        lspbuf.definition,
        { buffer = bufnr, desc = 'Jump to the definition of the symbol under the cursor (LSP)' }
      )
      km(
        'n',
        'grt',
        lspbuf.type_definition,
        { buffer = bufnr, desc = 'Jump to the definition of the type of the symbol under the cursor (LSP)' }
      )

      local server_capabilities = client.server_capabilities

      if server_capabilities.documentFormattingProvider then
        km(
          'n',
          'grf',
          buf_format,
          { buffer = bufnr, desc = 'Format a buffer using the attached LSP (LSP)' }
        )
      end

      if server_capabilities.documentRangeFormattingProvider then
        km(
          'v',
          'grf',
          buf_format,
          { buffer = bufnr, desc = 'Format the range using the attached LSP (LSP)' }
        )
      end
    end

    local fn_default_capabilities = require("cmp_nvim_lsp").default_capabilities
    -- local fn_default_capabilities = require('blink.cmp').get_lsp_capabilities

    lsp.config('*', {
      capabilities = fn_default_capabilities(),
      on_attach = on_attach,
    })

    lsp.config('lua_ls', {
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
    })

    lsp.config('jsonls', {
      before_init = function(_, client_config)
        client_config.settings.json.schemas = require('schemastore').json.schemas()
      end,
      settings = {
        json = {
          validate = { enable = true },
        },
      },
    })

    lsp.config('yamlls', {
      before_init = function(_, client_config)
        client_config.settings.yaml.schemas = require('schemastore').yaml.schemas()
      end,
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = ""
          },
        },
      },
    })

    lsp.config('ts_ls', {
      on_attach = function(client, bufnr)
        local server_capabilities                           = client.server_capabilities

        server_capabilities.documentFormattingProvider      = false
        server_capabilities.documentRangeFormattingProvider = false

        on_attach(client, bufnr)
      end
    })

    local ts_ls_capabilities = fn_default_capabilities()
    ts_ls_capabilities.offsetEncoding = { "utf-16" }

    lsp.config('ts_ls', {
      capabilities = ts_ls_capabilities,
    })

    require("mason").setup()

    require("mason-lspconfig").setup({ ensure_installed = lsp_servers })

    require('mason-null-ls').setup({ ensure_installed = linters_formatters })

    local null_ls = require('null-ls')
    -- local cspell = require("cspell")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.asmfmt,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.code_actions.gitsigns,
        -- cspell.diagnostics.with({
        --   diagnostics_postprocess = function(diag)
        --     diag.severity = vim.diagnostic.severity.HINT
        --   end,
        -- }),
        -- cspell.code_actions
      },
      on_attach = function(client, bufnr)
        local server_capabilities = client.server_capabilities

        if server_capabilities.documentFormattingProvider then
          km(
            'n',
            'grf',
            buf_format,
            { buffer = bufnr, desc = 'Format a buffer using the attached LSP (null-ls)' }
          )
        end

        if server_capabilities.documentRangeFormattingProvider then
          km(
            'v',
            'grf',
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
    -- 'davidmh/cspell.nvim',
    'jayp0521/mason-null-ls.nvim',
    'lewis6991/gitsigns.nvim',
    'mason-org/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls.nvim',
  }
}

return M
