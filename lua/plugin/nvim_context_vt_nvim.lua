local M = {
  'haringsrob/nvim_context_vt',
  config = function()
    local context_vt = require("nvim_context_vt")
    local context_vt_utils = require('nvim_context_vt.utils')

    context_vt.setup({
      enabled = false;
      custom_parser = function(node)
        return ' In “' .. context_vt_utils.get_node_text(node)[1] .. '”'
      end,
      highlight = 'Whitespace',
      disable_virtual_lines = true,
    })

    local ag = vim.api.nvim_create_augroup
    local ac = vim.api.nvim_create_autocmd

    local ag_nvim_context_vt_cfg = ag('nvim_context_vt_cfg', {})

    ac({ 'BufRead' }, {
      group = ag_nvim_context_vt_cfg,
      callback = function()
        if not vim.b.large_file_buf then
          vim.cmd("NvimContextVtToggle")
        end
      end
    })
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
}

return M
