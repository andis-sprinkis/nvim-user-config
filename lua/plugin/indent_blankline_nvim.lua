local M = {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require "ibl".setup({
      indent = { char = '│' },
      scope = { highlight = 'Normal' }
    })
    local hooks = require "ibl.hooks"
    hooks.register(
      hooks.type.ACTIVE,
      function(bufnr)
        return not vim.b.large_file_buf
      end
    )
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  }
}

return M
