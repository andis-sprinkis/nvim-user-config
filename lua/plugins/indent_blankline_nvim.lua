local M = {
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  branch = 'master',
  commit = 'f1e186e44d3b7f9ae918008e2c28ce37c6023d2d',
  config = function()
    require "ibl".setup({
      indent = { char = '│' },
    })
    local hooks = require "ibl.hooks"
    hooks.register(
      hooks.type.ACTIVE,
      function() return not vim.b.largef end
    )
  end,
  dependencies = {
    'https://github.com/nvim-treesitter/nvim-treesitter',
  }
}

return M
