local km = vim.keymap.set
local ac = vim.api.nvim_create_autocmd

local M = {
  'justinmk/vim-dirvish',
  config = function()
    vim.g.dirvish_mode = ':sort ,^.*[\\/],'

    vim.keymap.del('n', '-')

    km('n', '<leader>-', '<Plug>(dirvish_up)', { desc = "Show file directory (vim-dirvish)" })

    local ag_dirvish_usr = vim.api.nvim_create_augroup('dirvish_usr', {})

    ac(
      'Filetype',
      {
        group = ag_dirvish_usr,
        pattern = 'dirvish',
        callback = function()
          -- Workaround for https://github.com/justinmk/vim-dirvish/issues/257
          vim.opt_local.listchars = vim.opt.listchars:get()
          vim.opt_local.listchars:remove('precedes')

          km('n', '=', ':call dirvish#open("edit", 0)<CR>',
            { desc = "Open file at cursor (vim-dirvish)", silent = true, nowait = true, buffer = true })

          km('n', '-', '<Plug>(dirvish_up)',
            { desc = "Go up a directory (vim-dirvish)", silent = true, nowait = true, buffer = true })

          km('n', '/', '/\\c\\ze[^/]*[/]\\=$<Home><Right><Right>',
            { desc = "Search forward (vim-dirvish)", buffer = true })
          km('n', '?', '?\\c\\ze[^/]*[/]\\=$<Home><Right><Right>',
            { desc = "Search backward (vim-dirvish)", buffer = true })
        end
      }
    )

    local has_stdin = false

    ac(
      'StdinReadPre',
      {
        group = ag_dirvish_usr,
        callback = function()
          has_stdin = true
        end
      }
    )

    ac(
      'UIEnter',
      {
        group = ag_dirvish_usr,
        callback = function()
          if has_stdin or vim.fn.argc() > 0 or vim.tbl_contains(vim.v.argv, '+Man!') then return end

          vim.cmd.Dirvish()
        end
      }
    )
  end,
  lazy = false,
  priority = 900
}

return M
