local M = {
  'https://github.com/RRethy/vim-illuminate',
  branch = 'master',
  commit = '91313e598ca62e110bc71535c49069b66b9883c9',
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
