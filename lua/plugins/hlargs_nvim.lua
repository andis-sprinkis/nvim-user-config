local M = {
  'm-demare/hlargs.nvim',
  config = function()
    require('hlargs').setup {
      hl_priority = 200,
      disable = function ()
        return vim.b.large_file_buf
      end
    }
  end,
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }
}

return M
