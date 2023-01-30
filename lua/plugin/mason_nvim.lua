return function()
  local diagnostic = vim.diagnostic
  local lsp = vim.lsp
  local api = vim.api
  local lspbuf = lsp.buf
  local kms = vim.keymap.set

  local lsp_servers = {
    'awk_ls',
    'bashls',
    'clangd',
    'cmake',
    'cssls',
    'dockerls',
    'eslint',
    'html',
    'jsonls',
    'pylsp',
    'sumneko_lua',
    'tsserver',
    'yamlls',
  }

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  kms('n', '<Leader>d', diagnostic.open_float)
  kms('n', '[d', diagnostic.goto_prev)
  kms('n', ']d', diagnostic.goto_next)
  kms('n', '<Leader>q', diagnostic.setloclist)

  local function buf_format() lspbuf.format({ async = true }) end

  vim.api.nvim_create_user_command('Format', buf_format, { bang = true })

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local map_opts = { buffer = bufnr }
    local server_capabilities = client.server_capabilities

    require('illuminate').on_attach(client)

    -- Enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    kms('n', 'gD', lspbuf.declaration, map_opts)
    kms('n', 'gd', lspbuf.definition, map_opts)
    kms('n', 'K', lspbuf.hover, map_opts)
    kms('n', 'gi', lspbuf.implementation, map_opts)
    kms('n', '<C-s>', lspbuf.signature_help, map_opts)
    -- kms('n', '<Leader>wa', lspbuf.add_workLeader_folder, map_opts)
    -- kms('n', '<Leader>wr', lspbuf.remove_workLeader_folder, map_opts)
    -- kms('n', '<Leader>wl', function() print(vim.inspect(lspbuf.list_workLeader_folders())) end, map_opts)
    kms('n', '<Leader>D', lspbuf.type_definition, map_opts)
    -- vim.keymap.set('n', '<Leader>rn', lspbuf.rename, map_opts)
    kms('n', '<Leader>ca', lspbuf.code_action, map_opts)
    kms('n', 'gr', lspbuf.references, map_opts)

    if server_capabilities.documentFormattingProvider then
      kms('n', '<Leader>f', buf_format, map_opts)
    end

    if server_capabilities.documentRangeFormattingProvider then
      kms('x', '<Leader>f', buf_format, map_opts)
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
    local server_capabilities = client.server_capabilities

    server_capabilities.documentFormattingProvider      = false
    server_capabilities.documentRangeFormattingProvider = false
  end

  require("mason").setup()

  require("mason-lspconfig").setup({ ensure_installed = lsp_servers })

  local lspconfig = require("lspconfig")

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      lspconfig[server_name].setup(make_config())
    end,
    ["sumneko_lua"] = function()
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

      lspconfig.sumneko_lua.setup(config)
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
  })

  local null_ls = require('null-ls')

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.code_actions.gitsigns,
    },
    on_attach = function(client, bufnr)
      local map_opts = { buffer = bufnr }
      local server_capabilities = client.server_capabilities

      if server_capabilities.documentFormattingProvider then
        kms('n', '<Leader>f', buf_format, map_opts)
      end

      if server_capabilities.documentRangeFormattingProvider then
        kms('x', '<Leader>f', buf_format, map_opts)
      end
    end,
  })

  require('mason-null-ls').setup()
end
