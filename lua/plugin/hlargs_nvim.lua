local M = {
  'm-demare/hlargs.nvim',
  config = function()
    -- TODO: autocommand to detach from large buffers
    require('hlargs').setup {
      hl_priority = 200,
    }
  end,
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }
}

return M
