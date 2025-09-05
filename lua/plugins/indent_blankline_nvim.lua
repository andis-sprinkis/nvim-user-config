local M = {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require "ibl".setup({
      indent = { char = '│' },
    })
    local hooks = require "ibl.hooks"
    hooks.register(
      hooks.type.ACTIVE,
      function(bufnr)
        return not vim.b.largef
      end
    )
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  }
}

return M
