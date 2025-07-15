local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local disable = function()
      if vim.bo.ft == 'tmux' then
        return true
      end

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
