local M = {
  'https://github.com/catgoose/nvim-colorizer.lua',
  branch = 'master',
  commit = '72a05f62c52241bc7441c820eb53946f92b2e6a4',
  event = "VeryLazy",
  config = function()
    require("colorizer").setup {
      lazy_load = true,
      names_opts = {
        uppercase = true
      },
      user_default_options = {
        css = true,
        css_fn = true,
        mode = "virtualtext"
      }
    }

    local ac = vim.api.nvim_create_autocmd

    ac({ 'BufRead' }, {
      callback = function()
        if vim.b.largef then
          vim.cmd("ColorizerDetachFromBuffer")
        end
      end,
      desc = "Detach nvim-colorizer from large buffer (nvim-colorizer)"
    })
  end
}

return M
