local a = {}
local b = {
  'branch',
  { 'diff', colored = false },
  { 'filename', file_status = true, path = 1, shorting_target = 0 }
}
local c = {}
local x = { 'filetype' }
local y = { 'progress' }
local z = { 'location' }

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox_dark',
    component_separators = { left = '|', right = '|' },
    section_separators = {},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = a,
    lualine_b = b,
    lualine_c = c,
    lualine_x = x,
    lualine_y = y,
    lualine_z = z
  },
  inactive_sections = {
    lualine_a = a,
    lualine_b = b,
    lualine_c = c,
    lualine_x = x,
    lualine_y = y,
    lualine_z = z
  }
}
