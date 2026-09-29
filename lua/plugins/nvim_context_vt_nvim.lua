local M = {
  'https://github.com/andersevenrud/nvim_context_vt',
  branch = 'master',
  commit = '74c5ec8786426c5458e1a9f6b8b2fd6977ba01ab',
  config = function()
    local context_vt = require("nvim_context_vt")
    local context_vt_utils = require('nvim_context_vt.utils')

    context_vt.setup({
      custom_parser = function(node)
        return ' In “' .. context_vt_utils.get_node_text(node)[1] .. '”'
      end,
      highlight = 'Whitespace',
      disable_virtual_lines = true,
    })
  end,
  dependencies = { 'https://github.com/nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy'
}

return M
