local M = {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local disable = function()
      if
          vim.bo.ft == 'zathurarc'
          or vim.bo.ft == 'tmux'
          or vim.b.large_file_buf
      then
        return true
      end

      return false
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

    local ag_nvim_treesitter_cfg = ag('nvim_treesitter_cfg', {})

    ac({ 'BufRead' }, {
      group = ag_nvim_treesitter_cfg,
      callback = function()
        if disable() then return end

        local ol = vim.opt_local
        ol.foldmethod = 'expr'
        ol.foldenable = false
        ol.foldexpr = 'nvim_treesitter#foldexpr()'
      end
    })
  end
}

return M
