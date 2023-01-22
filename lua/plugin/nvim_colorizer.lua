return function()
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
