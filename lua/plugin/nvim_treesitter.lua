local M = {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    }

    local o = vim.opt
    o.foldmethod = 'expr'
    o.foldenable = false
    o.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
  build = ':TSUpdate'
}

return M
