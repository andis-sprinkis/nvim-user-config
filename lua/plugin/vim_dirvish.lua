local km = vim.keymap.set

local M = {
  'justinmk/vim-dirvish',
  config = function()
    vim.g.dirvish_mode = ':sort ,^.*[\\/],'

    vim.keymap.del('n', '-')

    km('n', '<leader>-', '<Plug>(dirvish_up)', { desc = "Show file directory (vim-dirvish)" })

    vim.api.nvim_create_autocmd(
      'Filetype',
      {
        group = vim.api.nvim_create_augroup('dirvish_usr', {}),
        pattern = 'dirvish',
        callback = function()
          -- Workaround for https://github.com/justinmk/vim-dirvish/issues/257
          vim.opt_local.listchars = vim.opt.listchars:get()
          vim.opt_local.listchars:remove('precedes')

          km('n', '-', '<Plug>(dirvish_up)',
            { desc = "Go up a directory (vim-dirvish)", buffer = true })

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
