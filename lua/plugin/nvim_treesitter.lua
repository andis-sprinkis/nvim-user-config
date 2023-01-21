return function()
  require 'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    indent = {
      enable = true
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
end
