local M = {
  'https://github.com/catgoose/nvim-colorizer.lua',
  branch = 'master',
  commit = '664c0b7cea1de71f8b65dfe951b7996fc3e6ccde',
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
      end
    })
  end
}

return M
