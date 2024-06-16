local M = {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local exclude_filetypes = {
      dirvish = true,
      lazy = true,
      fugitive = true,
    }
    require("hlchunk").setup({
      chunk = {
        enable = true,
        exclude_filetypes = exclude_filetypes
      },
      indent = {
        enable = true,
        exclude_filetypes = exclude_filetypes
      },
      line_num = {
        enable = true,
        exclude_filetypes = exclude_filetypes
      },
      blank = {
        enable = false,
        exclude_filetypes = exclude_filetypes
      }
    })
  end
}

return M
