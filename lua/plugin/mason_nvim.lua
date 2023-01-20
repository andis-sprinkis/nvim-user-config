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
    'eslint',
    'html',
    'jsonls',
    'pylsp',
    'sumneko_lua',
    'tsserver',
  }

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local map_opts = { silent = true }
  kms({ 'n' }, '<Leader>d', diagnostic.open_float, map_opts)
  kms({ 'n' }, '[d', diagnostic.goto_prev, map_opts)
  kms({ 'n' }, ']d', diagnostic.goto_next, map_opts)
  kms({ 'n' }, '<Leader>q', diagnostic.setloclist, map_opts)

  local function buf_format() lspbuf.format({ async = true }) end

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local buf_map_opts = { silent = true, buffer = bufnr }
    local server_capabilities = client.server_capabilities

    require 'illuminate'.on_attach(client)

    -- Enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    kms({ 'n' }, 'gD', lspbuf.declaration, buf_map_opts)
    kms({ 'n' }, 'gd', lspbuf.definition, buf_map_opts)
    kms({ 'n' }, 'K', lspbuf.hover, buf_map_opts)
    kms({ 'n' }, 'gi', lspbuf.implementation, buf_map_opts)
    kms({ 'n' }, '<C-s>', lspbuf.signature_help, buf_map_opts)
    -- kms({ 'n' }, '<Leader>wa', lspbuf.add_workLeader_folder, buf_map_opts)
    -- kms({ 'n' }, '<Leader>wr', lspbuf.remove_workLeader_folder, buf_map_opts)
    -- kms({ 'n' }, '<Leader>wl', function() print(vim.inspect(lspbuf.list_workLeader_folders())) end, buf_map_opts)
    kms({ 'n' }, '<Leader>D', lspbuf.type_definition, buf_map_opts)
    -- vim.keymap.set({ 'n' }, '<Leader>rn', lspbuf.rename, buf_map_opts)
    kms({ 'n' }, '<Leader>ca', lspbuf.code_action, buf_map_opts)
    kms({ 'n' }, 'gr', lspbuf.references, buf_map_opts)

    if server_capabilities.documentFormattingProvider then
      kms({ 'n' }, '<Leader>f', buf_format, buf_map_opts)
    end

    if server_capabilities.documentRangeFormattingProvider then
      kms({ 'x' }, '<Leader>f', buf_format, buf_map_opts)
    end

    vim.api.nvim_create_user_command(
      'Format',
      buf_format,
      { bang = true }
    )
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local function make_config()
    return {
      capabilities = capabilities,
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
      local config = make_config()
      lspconfig[server_name].setup(config)
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
    },
    on_attach = function(client, bufnr)
      local buf_map_opts = { silent = true, buffer = bufnr }
      local server_capabilities = client.server_capabilities

      if server_capabilities.documentFormattingProvider then
        kms({ 'n' }, '<Leader>f', buf_format, buf_map_opts)
      end

      if server_capabilities.documentRangeFormattingProvider then
        kms({ 'x' }, '<Leader>f', buf_format, buf_map_opts)
      end
    end,
  })

  require('mason-null-ls').setup()
end
