local M = {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  event = 'VeryLazy'
}

return M
