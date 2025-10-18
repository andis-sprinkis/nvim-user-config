local M = {
  'https://github.com/numToStr/Comment.nvim',
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    }
  end,
  dependencies = {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    {
      'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require('ts_context_commentstring').setup {
          enable_autocmd = false,
        }
      end
    }
  },
  keys = {
    { "gc", mode = { "n", "v" } },
    { "gb", mode = { "n", "v" } },
  },
}

return M
