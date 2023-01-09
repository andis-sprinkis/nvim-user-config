return function()
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
  vim.keymap.set({ 'n' }, '<Leader>d', vim.diagnostic.open_float, map_opts)
  vim.keymap.set({ 'n' }, '[d', vim.diagnostic.goto_prev, map_opts)
  vim.keymap.set({ 'n' }, ']d', vim.diagnostic.goto_next, map_opts)
  vim.keymap.set({ 'n' }, '<Leader>q', vim.diagnostic.setloclist, map_opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local buf_map_opts = { silent = true, buffer = bufnr }

    require 'illuminate'.on_attach(client)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set({ 'n' }, 'gD', vim.lsp.buf.declaration, buf_map_opts)
    vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.definition, buf_map_opts)
    vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, buf_map_opts)
    vim.keymap.set({ 'n' }, 'gi', vim.lsp.buf.implementation, buf_map_opts)
    vim.keymap.set({ 'n' }, '<C-s>', vim.lsp.buf.signature_help, buf_map_opts)
    -- vim.keymap.set({ 'n' }, '<Leader>wa', vim.lsp.buf.add_workLeader_folder, buf_map_opts)
    -- vim.keymap.set({ 'n' }, '<Leader>wr', vim.lsp.buf.remove_workLeader_folder, buf_map_opts)
    -- vim.keymap.set({ 'n' }, '<Leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workLeader_folders())) end, buf_map_opts)
    vim.keymap.set({ 'n' }, '<Leader>D', vim.lsp.buf.type_definition, buf_map_opts)
    -- vim.keymap.set({ 'n' }, '<Leader>rn', vim.lsp.buf.rename, buf_map_opts)
    vim.keymap.set({ 'n' }, '<Leader>ca', vim.lsp.buf.code_action, buf_map_opts)
    vim.keymap.set({ 'n' }, 'gr', vim.lsp.buf.references, buf_map_opts)

    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set({ 'n' }, '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, buf_map_opts)
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.keymap.set({ 'x' }, '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, buf_map_opts)
    end

    if client.server_capabilities.documentHighlightProvider then
      vim.cmd([[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
    end

    vim.api.nvim_create_user_command(
      'Format',
      function()
        vim.lsp.buf.format({ async = true })
      end,
      { bang = true }
    )
  end

  local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    return {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end

  local function remove_formatting_capabilities(client)
    client.server_capabilities.documentFormattingProvider      = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local lspconfig = require("lspconfig")

  require("mason").setup()
  require("mason-lspconfig").setup({ ensure_installed = lsp_servers })

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

      if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set({ 'n' }, '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, buf_map_opts)
      end

      if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set({ 'x' }, '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, buf_map_opts)
      end
    end,
  })

  require('mason-null-ls').setup()
end
