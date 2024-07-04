local M = {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local disable = function()
      return vim.b.large_file_buf
    end

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
        disable = disable,
      },
      indent = {
        enable = true,
        disable = disable,
      }
    }

    local ag = vim.api.nvim_create_augroup
    local ac = vim.api.nvim_create_autocmd

    local ag_nvim_treesitter_cfg = ag('nvim_treesitter_cfg', { clear = true })

    ac({ 'BufRead' }, {
      group = ag_nvim_treesitter_cfg,
      callback = function()
        if not disable() then
          local ol = vim.opt_local
          ol.foldmethod = 'expr'
          ol.foldenable = false
          ol.foldexpr = 'nvim_treesitter#foldexpr()'
        end
      end
    })
  end,
  build = ':TSUpdate'
}

return M
