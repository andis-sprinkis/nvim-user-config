local M = {
  'https://github.com/RRethy/vim-illuminate',
  branch = 'master',
  commit = '0d1e93684da00ab7c057410fecfc24f434698898',
  config = function()
    require('illuminate').configure({
      filetypes_denylist = {},
      delay = 675,
      should_enable = function(buf)
        return not vim.b.largef
      end
    })
  end,
  dependencies = { 'https://github.com/nvim-treesitter/nvim-treesitter' }
}

return M
