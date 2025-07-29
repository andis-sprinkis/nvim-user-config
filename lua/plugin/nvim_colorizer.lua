local M = {
  'catgoose/nvim-colorizer.lua',
  event = "VeryLazy",
  config = function()
    require("colorizer").setup {
      lazy_load = true,
      names_opts = {
        uppercase = true
      },
      user_default_options = {
        css = true,
        css_fn = true,
        mode = "virtualtext"
      }
    }

    local ag = vim.api.nvim_create_augroup
    local ac = vim.api.nvim_create_autocmd

    local ag_vim_colorizer_cfg = ag('vim_colorizer_cfg', {})

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
