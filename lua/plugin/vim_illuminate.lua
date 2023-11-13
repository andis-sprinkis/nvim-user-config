local M = {
  'RRethy/vim-illuminate',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    table.insert(vim.g.large_file_callbacks, function()
      vim.cmd("IlluminatePauseBuf")
    end)
  end
}

return M
