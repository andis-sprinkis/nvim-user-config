return function()
  require('indent_blankline').setup({
    show_current_context = true,
    show_current_context_start = true,
    show_current_context_start_on_current_line = false,
    show_end_of_line = true,
    show_first_indent_level = true,
    char = '▏',
    blankline_char = '▏',
    context_char = '▏',
    filetype_exclude = {
      'help',
      'spectre_panel'
    },
  })
end
