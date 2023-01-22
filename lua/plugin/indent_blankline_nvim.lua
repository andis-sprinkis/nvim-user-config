return function()
  require('indent_blankline').setup({
    show_current_context = true,
    show_current_context_start = true,
    show_first_indent_level = true,
    show_end_of_line = true,
    char = '▏',
    blankline_char = '▏',
    filetype_exclude = {
      '',
      'Fm',
      'help',
      'lsp-installer',
      'man',
      'packer',
      'spectre_panel',
      'terminal',
    },
  })
end
