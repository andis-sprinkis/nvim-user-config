local M = {
  'https://github.com/RRethy/vim-illuminate',
  branch = 'master',
  commit = '1cc33d347c574c3bd21a4852fc9ffed677c1c58c',
  config = function()
    require('illuminate').configure({
      filetypes_denylist = {},
      delay = 675,
      should_enable = function() return not vim.b.largef end
    })
  end,
  dependencies = { 'https://github.com/nvim-treesitter/nvim-treesitter' }
}

return M
