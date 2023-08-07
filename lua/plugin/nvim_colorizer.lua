local M = {
  'NvChad/nvim-colorizer.lua',
  config = function()
    require("colorizer").setup {
      user_default_options = {
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        mode = "virtualtext"
      }
    }
  end
}

return M
