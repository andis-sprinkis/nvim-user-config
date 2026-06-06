local M = {
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  branch = 'master',
  commit = 'd28a3f70721c79e3c5f6693057ae929f3d9c0a03',
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
