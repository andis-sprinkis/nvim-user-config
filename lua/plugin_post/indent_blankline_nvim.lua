require('indent_blankline').setup({
  show_current_context = true,
  show_first_indent_level = true,
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
