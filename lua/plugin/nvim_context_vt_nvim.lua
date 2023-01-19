return function()
  require("nvim_context_vt").setup({
    custom_parser = function(node, ft, opts)
      return node:type() == 'function' and nil or
          '  In "' .. require('nvim_context_vt.utils').get_node_text(node)[1] .. '"'
    end,
    highlight = 'Whitespace',
    disable_virtual_lines = true,
  })
end
