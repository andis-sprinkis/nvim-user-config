local M = {
  'RRethy/vim-illuminate',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('illuminate').configure({
      filetypes_denylist = {},
      should_enable = function(buf)
        return not vim.b.large_file_buf
      end
    })
  end
}

return M
