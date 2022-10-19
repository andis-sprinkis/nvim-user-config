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
  local map_opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', map_opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', map_opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', map_opts)
  vim.api.nvim_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', map_opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    require 'illuminate'.on_attach(client)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workLeader_folder()<CR>', map_opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workLeader_folder()<CR>', map_opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workLeader_folders()))<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', map_opts)
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.api.nvim_buf_set_keymap(bufnr, 'x', '<Leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', map_opts)
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

    vim.cmd([[command! Format execute 'lua vim.lsp.buf.format({ async = true })']])
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
    client.server_capabilities.documentFormattingProvider  = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local lspconfig = require("lspconfig")

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = lsp_servers
  })

  require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler
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
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", map_opts)
      end

      if client.server_capabilities.documentRangeFormattingProvider then
        vim.api.nvim_buf_set_keymap(bufnr, "x", "<Leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", map_opts)
      end
    end,
  })

  require('mason-null-ls').setup()
end
