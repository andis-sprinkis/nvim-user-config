return function()
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
    rainbow = {
      enable = true,
    }
  }

  local o = vim.opt
  o.foldmethod = 'expr'
  o.foldenable = false
  o.foldexpr = 'nvim_treesitter#foldexpr()'
end