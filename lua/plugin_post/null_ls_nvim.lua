local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
  on_attach = function(client, bufnr)
    local map_opts = { noremap = true, silent = true }

    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", map_opts)
    end

    if client.resolved_capabilities.document_range_formatting then
      vim.api.nvim_buf_set_keymap(bufnr, "x", "<Leader>f", "<cmd>lua vim.lsp.buf.range_formatting({})<CR>", map_opts)
    end
  end,
})