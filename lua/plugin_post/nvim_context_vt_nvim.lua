return function ()
  require("nvim_context_vt").setup({
    custom_parser = function(node, ft, opts)
      local utils = require('nvim_context_vt.utils')
      if node:type() == 'function' then return nil end
      return '  In "' .. utils.get_node_text(node)[1] .. '"'
    end,
    highlight = 'Whitespace',
  })
end
