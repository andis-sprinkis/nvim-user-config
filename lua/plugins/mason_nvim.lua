local sys_reqr = vim.g.sys_reqr
local lsp = vim.lsp

local M = {
  'https://github.com/mason-org/mason.nvim',
  branch = 'main',
  commit = '16ba83bfc8a25f52bb545134f5bee082b195c460',
  enabled = sys_reqr.lsp_plugins,
  init = function()
    vim.lsp.log.set_level("OFF")
  end,
  config = function()
    local diagnostic = vim.diagnostic
    local lspbuf = lsp.buf
    local b = vim.b
    local bo = vim.bo
    local api = vim.api
    local km = vim.keymap.set

    diagnostic.config({
      severity_sort = true,
      virtual_lines = {
        current_line = true
      },
    })

    -- https://github.com/mason-org/mason-registry/tree/main/packages

    local lsp_servers = {
      'awk_ls@0.10.6',
      'bashls@5.6.0',
      -- 'clangd@22.1.6',
      'cssls@4.10.0',
      'dockerls@0.15.0',
      'eslint@4.10.0',
      'html@4.10.0',
      'jsonls@4.10.0',
      'lua_ls@3.18.2',
      -- 'pylsp@1.14.0?extra=all',
      'ruff@0.15.15',
      'stylelint_lsp@1.1.1',
      'ts_ls@5.3.0',
      'yamlls@1.23.0',
    }

    if sys_reqr.lsp_neocmake then table.insert(lsp_servers, 'neocmake@v0.10.2') end
    if sys_reqr.lsp_asm then table.insert(lsp_servers, 'asm_lsp@0.10.1') end

    local linters_formatters = {
      'asmfmt@v1.3.2',
      'prettier@3.8.3',
      'shellcheck@v0.11.0',
      'checkmake@v0.3.2',
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

    -- To use 'prettier' insead of the LSP formatting capabilities
    local function rm_formatting_capabilities(client, bufnr)
      local server_capabilities                           = client.server_capabilities

      server_capabilities.documentFormattingProvider      = false
      server_capabilities.documentRangeFormattingProvider = false

      on_attach(client, bufnr)
    end

    local fn_default_capabilities = require("cmp_nvim_lsp").default_capabilities

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
      on_attach = rm_formatting_capabilities,
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

    lsp.config('css_ls', {
      on_attach = rm_formatting_capabilities,
    })

    lsp.config('html', {
      on_attach = rm_formatting_capabilities,
    })

    lsp.config('ts_ls', {
      on_attach = rm_formatting_capabilities,
    })

    local clangd_capabilities = fn_default_capabilities()
    clangd_capabilities.offsetEncoding = { "utf-16" }

    lsp.config('clangd', {
      capabilities = clangd_capabilities,
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
    --     if vim.b.largef then
    --       vim.defer_fn(function()
    --         vim.cmd [[LspStop]]
    --         vim.notify(
    --           "LSP clients for the buffer were stopped because it is large."
    --         )
    --       end, 10)
    --     end
    --   end,
    --   desc = "TODO DESC (user)"
    -- })
    --

    local ft_ignore_lsp = { 'dirvish', 'futigive', 'lazy', 'mason', 'man', 'help', 'qf', '' }
    local lsp_severity = { { 1, 'E' }, { 2, 'W' }, { 3, 'I' }, { 4, 'H' } }

    api.nvim_create_autocmd(
      'DiagnosticChanged',
      {
        callback = function()
          if bo.buftype ~= ''
              or vim.tbl_contains(ft_ignore_lsp, bo.ft)
              or vim.tbl_isempty(lsp.get_clients({ bufnr = 0 }))
          then
            b.statl_lsp = nil
            return
          end

          local msg = {}

          for _, ty in ipairs(lsp_severity) do
            local n = diagnostic.get(0, { severity = ty[1] })
            if #n > 0 then
              table.insert(msg, ty[2] .. ':' .. #n)
            end
          end

          b.statl_lsp = #msg > 0 and table.concat(msg, ' ') or nil
        end,
        desc = "TODO DESC (user)"
      }
    )
  end,
  dependencies = {
    'https://github.com/RRethy/vim-illuminate',
    {
      'https://github.com/b0o/schemastore.nvim',
      branch = 'main',
      commit = 'efa62017f59a6346486cc567d70acce965a00b12',
    },
    {
      'https://github.com/jayp0521/mason-null-ls.nvim',
      branch = 'main',
      commit = '8e7806acaa87fae64f0bfde25bb4b87c18bd19b4',
    },
    'https://github.com/lewis6991/gitsigns.nvim',
    {
      'https://github.com/mason-org/mason-lspconfig.nvim',
      branch = 'main',
      commit = '7b01e2974a47d489bb92f47a41e4c0088ea8f86e',
    },
    {
      'https://github.com/neovim/nvim-lspconfig',
      branch = 'master',
      commit = '9573948c38bfabeec353ae7dd7d3ffec4c506a6b',
    },
    {
      'https://github.com/nvimtools/none-ls.nvim',
      branch = 'main',
      commit = 'f9d557ac7cd28a3a993b5ea49716498bd540b01f',
      dependencies = {
        'https://github.com/nvim-lua/plenary.nvim',
        branch = 'master',
        commit = '74b06c6c75e4eeb3108ec01852001636d85a932b',
      }
    },
  }
}

return M
