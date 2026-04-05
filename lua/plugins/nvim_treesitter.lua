local M = {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  enabled = vim.g.sys_reqr.nvim_treesitter,
  config = function()
    local disable = function()
      return vim.b.largef
    end

    local ft = {
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
    require('nvim-treesitter').install(ft)

    local api = vim.api

    local ag_nvim_treesitter_cfg = api.nvim_create_augroup('nvim_treesitter_cfg', {})

    vim.api.nvim_create_autocmd(
      'FileType', {
        group = ag_nvim_treesitter_cfg,
        pattern = ft,
        callback = function()
          if disable() then return end

          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      }
    )
  end
}

return M
