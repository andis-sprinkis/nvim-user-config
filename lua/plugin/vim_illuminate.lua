local M = {
  'RRethy/vim-illuminate',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    table.insert(vim.g.large_file_callbacks, function()
      vim.cmd("IlluminatePauseBuf")
    end)

    require('illuminate').configure({
      filetypes_denylist = {},
    })
  end
}

return M
