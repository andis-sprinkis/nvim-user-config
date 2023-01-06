return function()
  require 'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",
    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }

  vim.cmd([[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set nofoldenable
  ]])
end
