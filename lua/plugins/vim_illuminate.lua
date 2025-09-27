local M = {
  'https://github.com/RRethy/vim-illuminate',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('illuminate').configure({
      filetypes_denylist = {},
      delay = 675,
      should_enable = function(buf)
        return not vim.b.largef
      end
    })
  end
}

return M
