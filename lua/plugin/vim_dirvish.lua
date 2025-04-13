local km = vim.keymap.set

local M = {
  'justinmk/vim-dirvish',
  config = function()
    vim.g.dirvish_mode = ':sort ,^.*[\\/],'

    local au_dirvish_usr = vim.api.nvim_create_augroup('dirvish_usr', { clear = true })

    vim.api.nvim_create_autocmd(
      { 'Filetype' },
      {
        group = au_dirvish_usr,
        pattern = 'dirvish',
        callback = function()
          vim.opt_local.list = false

          km('n', '/', '/\\c\\ze[^/]*[/]\\=$<Home><Right><Right>',
            { desc = "Search forward (vim-dirvish)", buffer = true })
          km('n', '?', '?\\c\\ze[^/]*[/]\\=$<Home><Right><Right>',
            { desc = "Search backward (vim-dirvish)", buffer = true })
        end
      }
    )
  end,
  lazy = false,
  priority = 900
}

return M
