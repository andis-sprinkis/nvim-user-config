local M = {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  enabled = vim.g.sys_reqr.nvim_treesitter,
  config = function()
    require('nvim-treesitter').install(
      {
        'awk',
        'bash',
        'cpp',
        'css',
        'gitcommit',
        'html',
        'java',
        'javascript',
        'json',
        'make',
        'styled',
        'tsx',
        'typescript',
        'xml',
        'yaml'
      }
    )

    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'

    -- local disable = function()
    --   return vim.b.largef
    -- end
    --
    -- require 'nvim-treesitter.configs'.setup {
    --   ensure_installed = {
    --     'awk',
    --     'bash',
    --     'cpp',
    --     'css',
    --     'gitcommit',
    --     'html',
    --     'java',
    --     'javascript',
    --     'json',
    --     'make',
    --     'styled',
    --     'tsx',
    --     'typescript',
    --     'xml',
    --     'yaml'
    --   },
    --   highlight = {
    --     enable = true,
    --     disable = disable,
    --   },
    --   indent = {
    --     enable = true,
    --     disable = disable,
    --   },
    --   incremental_selection = {
    --     enable = true,
    --     disable = disable,
    --   },
    --   textobjects = {
    --     enable = true,
    --     disable = disable,
    --   },
    -- }
    --
    -- local api = vim.api
    --
    -- local ag_nvim_treesitter_cfg = api.nvim_create_augroup('nvim_treesitter_cfg', {})
    --
    -- api.nvim_create_autocmd({ 'BufRead' }, {
    --   group = ag_nvim_treesitter_cfg,
    --   callback = function()
    --     if disable() then return end
    --
    --     local ol = vim.opt_local
    --     ol.foldmethod = 'expr'
    --     ol.foldenable = false
    --     ol.foldexpr = 'nvim_treesitter#foldexpr()'
    --   end
    -- })
  end
}

return M
