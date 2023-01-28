return function ()
  require('fm-nvim').setup {
    ui = {
      default = "float",
      float = {
        border = "rounded",
        blend = 10,
        height = 0.9375,
        width = 0.9375,
        y = 0.25,
      }
    }
  }
end
