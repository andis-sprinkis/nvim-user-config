local M = {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local disable = function(lang, buf)
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
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
        disable = disable,
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
