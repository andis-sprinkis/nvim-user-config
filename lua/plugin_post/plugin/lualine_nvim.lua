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

local weighted_width = function(percentage, weight_multiplier)
  local full_width_minimum = 350
  local distance_to_full_width_minimum = vim.fn.winwidth(0) / full_width_minimum
  if distance_to_full_width_minimum >= 1 then distance_to_full_width_minimum = 1 end

  local weight = distance_to_full_width_minimum * weight_multiplier
  if weight >= 1 then weight = 1 end

  local width_allocated_by_percentage = (vim.fn.winwidth(0) / 100) * percentage
  local weighted_component_width = width_allocated_by_percentage * weight

  return weighted_component_width
end

local fmt_data = function(data, alignment, section_width, hide_treshold)
  if (hide_treshold ~= nil and vim.fn.winwidth(0) < hide_treshold) then
    return 0
  end

  if (alignment == 'left') then
    if (string.len(data) <= section_width) then
      return data:sub(1,section_width)
    else
      return data:sub(1,section_width - 1) .. '>'
    end
  end

  if (alignment == 'right') then
    if (string.len(data) <= section_width) then
      return data:sub(-section_width)
    else
      return '<' .. data:sub(-section_width + 1)
    end
  end
end

local git_head = function()
  if (vim.g.plug_requirement.git_plugins) then
    return vim.fn.FugitiveHead()
  end

  return ''
end

local sections = {
  lualine_a = { },
  lualine_b = {
    {
      function()
        local head = git_head()
        if (head ~= '') then
          if vim.fn.winwidth(0) < 70 then return '' end
          return ' ' .. head
        end

        return ''
      end,
      fmt = function(data) return fmt_data(data, 'left', weighted_width(20, 4), 40) end
    },
    {
      'diff',
      colored = false,
      fmt = function(data) return fmt_data(data, 'left', weighted_width(22, 7), 80) end
    },
    {
      'filename',
      file_status = true,
      path = 1,
      shorting_target = 0,
      fmt = function(data)
        if (git_head() ~= '') then
          return fmt_data(data, 'right', weighted_width(70, 2))
        end

        return fmt_data(data, 'right', weighted_width(70, 4))
      end
    }
  },
  lualine_c = { },
  lualine_x = {
    {
      'filetype',
      fmt = function(data) return fmt_data(data, 'right', weighted_width(25, 5), 50) end
    }
  },
  lualine_y = {
    {
      'progress',
      fmt = function(data) return fmt_data(data, 'right', weighted_width(1000, 1000), 20) end
    }
  },
  lualine_z = {
    {
      'location',
      fmt = function(data) return fmt_data(data, 'right', weighted_width(1000, 1000), 20) end
    }
  }
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = '|',
    section_separators = {},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = sections,
  inactive_sections = sections
}
