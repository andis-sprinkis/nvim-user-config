local M = {
  'NvChad/nvim-colorizer.lua',
  config = function()
    require("colorizer").setup {
      user_default_options = {
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        mode = "virtualtext"
      }
    }

    local ag = vim.api.nvim_create_augroup
    local ac = vim.api.nvim_create_autocmd

    local ag_vim_colorizer_cfg = ag('vim_colorizer_cfg', { clear = true })

    ac({ 'BufRead' }, {
      group = ag_vim_colorizer_cfg,
      callback = function()
        if vim.b.large_file_buf then
          vim.cmd("ColorizerDetachFromBuffer")
        end
      end
    })
  end
}

return M
