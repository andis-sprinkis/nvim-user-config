local colors = {
  base03  ='#282828',
  base02  ='#3c3836',
  base01  ='#504945',
  base00  ='#665c54',
  base0   ='#7c6f64',
  base1   ='#928374',
  base2   ='#a89984',
  base3   ='#ebdbb2',
  yellow  ='#d79921',
  orange  ='#d65d0e',
  red     ='#fb3934',
  magenta ='#b16286',
  peach   ='#d3869b',
  blue    ='#458588',
  cyan    ='#83a598',
  green   ='#b8bb26',
  white   ='#ebdbb2',
}

local theme = {
  normal = {
    a = { bg = colors.cyan, fg = colors.base03 },
    b = { bg = colors.base01, fg = colors.base3 },
    c = { bg = colors.base02, fg = colors.base1 },
    x = { bg = colors.base02, fg = colors.base2 },
    y = { bg = colors.base01, fg = colors.base2 },
    z = { bg = colors.base0, fg = colors.base03 },
  },
  insert = {
    a = { bg = colors.green, fg = colors.base03 },
    b = { bg = colors.base01, fg = colors.base3 },
    c = { bg = colors.base02, fg = colors.base1 },
    x = { bg = colors.base02, fg = colors.base2 },
    y = { bg = colors.base01, fg = colors.base2 },
    z = { bg = colors.base0, fg = colors.base03 },
  },
  visual = {
    a = { bg = colors.peach, fg = colors.base03 },
    b = { bg = colors.base01, fg = colors.base3 },
    c = { bg = colors.base02, fg = colors.base1 },
    x = { bg = colors.base02, fg = colors.base2 },
    y = { bg = colors.base01, fg = colors.base2 },
    z = { bg = colors.base0, fg = colors.base03 },
  },
  replace = {
    a = { bg = colors.yellow, fg = colors.base03 },
    b = { bg = colors.base01, fg = colors.base3 },
    c = { bg = colors.base02, fg = colors.base1 },
    x = { bg = colors.base02, fg = colors.base2 },
    y = { bg = colors.base01, fg = colors.base2 },
    z = { bg = colors.base0, fg = colors.base03 },
  },
  command = {
    a = { bg = colors.cyan, fg = colors.base03 },
    b = { bg = colors.base01, fg = colors.base3 },
    c = { bg = colors.base02, fg = colors.base1 },
    x = { bg = colors.base02, fg = colors.base2 },
    y = { bg = colors.base01, fg = colors.base2 },
    z = { bg = colors.base0, fg = colors.base03 },
  },
  inactive = {
    a = { bg = colors.base01, fg = colors.base03 },
    b = { bg = colors.base02, fg = colors.base1 },
    c = { bg = colors.base02, fg = colors.base0 },
    x = { bg = colors.base02, fg = colors.base0 },
    y = { bg = colors.base02, fg = colors.base0 },
    z = { bg = colors.base01, fg = colors.base03 },
  },
}

local a = {}
local b = {
  'branch',
  { 'diff', colored = false },
  { 'filename', file_status = true, path = 1, shorting_target = 0 }
}
local c = { }
local x = { 'filetype' }
local y = { 'progress' }
local z = { 'location' }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = theme,
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
