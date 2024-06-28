local M = {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local disable = function(lang, buf)
      return vim.b.large_file_buf
    end

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
        disable = function (lang, buf)
          local langs_disable = {}

          for i in ipairs(langs_disable) do
            if (langs_disable[i] == lang) then
              return true
            end
          end

          return disable(lang, buf)
        end,
      },
      indent = {
        enable = true,
        disable = disable,
      }
    }

    local o = vim.opt
    o.foldmethod = 'expr'
    o.foldenable = false
    o.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
  build = ':TSUpdate'
}

return M
