local M = {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local disable = function()
      return vim.b.large_file_buf
    end

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        'awk',
        'cpp',
        'css',
        'html',
        'javascript',
        'json',
        'make',
        'tsx',
        'typescript',
        'xml',
        'yaml'
      },
      highlight = {
        enable = true,
        disable = disable,
      },
      indent = {
        enable = true,
        disable = disable,
      },
      incremental_selection = {
        enable = true,
        disable = disable,
      },
      textobjects = {
        enable = true,
        disable = disable,
      },
    }

    local api = vim.api

    local ag_nvim_treesitter_cfg = api.nvim_create_augroup('nvim_treesitter_cfg', {})

    api.nvim_create_autocmd({ 'BufRead' }, {
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
