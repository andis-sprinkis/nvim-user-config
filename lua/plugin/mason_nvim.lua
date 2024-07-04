local g = vim.g
local sys_reqr = g.sys_reqr

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
      'awk_ls',
      'bashls',
      'clangd',
      'cssls',
      'dockerls',
      'eslint',
      'html',
      'jsonls',
      'lua_ls',
      'pylsp',
      'stylelint_lsp',
      'texlab',
      'tsserver',
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
      'shellcheck'
    }

    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    km('n', '<Leader>d', diagnostic.open_float)
    km('n', '[d', diagnostic.goto_prev)
    km('n', ']d', diagnostic.goto_next)
    km('n', '<Leader>q', diagnostic.setloclist)

    local function buf_format() lspbuf.format({ async = true }) end

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local map_opts = { buffer = bufnr }
      local server_capabilities = client.server_capabilities

      -- Enable completion triggered by <c-x><c-o>
      api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      km('n', 'gD', lspbuf.declaration, map_opts)
      km('n', 'gd', lspbuf.definition, map_opts)
      km('n', 'K', lspbuf.hover, map_opts)
      km('n', 'gi', lspbuf.implementation, map_opts)
      km('n', '<C-s>', lspbuf.signature_help, map_opts)
      -- km('n', '<Leader>wa', lspbuf.add_workLeader_folder, map_opts)
      -- km('n', '<Leader>wr', lspbuf.remove_workLeader_folder, map_opts)
      -- km('n', '<Leader>wl', function() print(vim.inspect(lspbuf.list_workLeader_folders())) end, map_opts)
      km('n', '<Leader>D', lspbuf.type_definition, map_opts)
      km('n', '<Leader>rn', lspbuf.rename, map_opts)
      km('n', '<Leader>ca', lspbuf.code_action, map_opts)
      km('n', 'gr', lspbuf.references, map_opts)

      if server_capabilities.documentFormattingProvider then
        km('n', '<Leader>f', buf_format, map_opts)
      end

      if server_capabilities.documentRangeFormattingProvider then
        km('x', '<Leader>f', buf_format, map_opts)
      end
    end

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local function make_config()
      return {
        capabilities = cmp_nvim_lsp.default_capabilities(),
        on_attach = on_attach,
      }
    end

    local function remove_formatting_capabilities(client)
      local server_capabilities                           = client.server_capabilities

      server_capabilities.documentFormattingProvider      = false
      server_capabilities.documentRangeFormattingProvider = false
    end

    -- TODO: autocommand to detach from large buffers
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
            diagnostics = {
              globals = { 'vim' },
            },
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
      ["tsserver"] = function()
        local config = make_config()

        config.on_attach = function(client, bufnr)
          remove_formatting_capabilities(client)
          on_attach(client, bufnr)
        end

        lspconfig.tsserver.setup(config)
      end,
      ["clangd"] = function()
        local config = make_config()
        config.capabilities.offsetEncoding = { "utf-16" }
        lspconfig.clangd.setup(config)
      end
    })

    -- TODO: autocommand to detach from large buffers
    require('mason-null-ls').setup({ ensure_installed = linters_formatters })

    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.asmfmt,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.gitsigns,
      },
      on_attach = function(client, bufnr)
        local map_opts = { buffer = bufnr }
        local server_capabilities = client.server_capabilities

        if server_capabilities.documentFormattingProvider then
          km('n', '<Leader>f', buf_format, map_opts)
        end

        if server_capabilities.documentRangeFormattingProvider then
          km('x', '<Leader>f', buf_format, map_opts)
        end
      end,
    })

    require('mason-nvim-dap').setup({
      automatic_setup = true,
      ensure_installed = dap_providers
    })
  end,
  dependencies = {
    'b0o/schemastore.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'jayp0521/mason-null-ls.nvim',
    'nvimtools/none-ls.nvim',
    'nvim-lua/plenary.nvim',
    'lewis6991/gitsigns.nvim',
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'mfussenegger/nvim-dap',
    'RRethy/vim-illuminate',
  }
}

return M
