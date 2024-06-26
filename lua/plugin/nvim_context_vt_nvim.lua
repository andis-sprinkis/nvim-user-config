local M = {
  'haringsrob/nvim_context_vt',
  config = function()
    -- TODO: autocommand to detach from large buffers
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
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy'
}

return M
