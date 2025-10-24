local M = {
  'https://github.com/lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      sign_priority = 11
    }

    local api = vim.api

    local ft_ignore_git = { 'lazy', 'mason', 'man', 'help' }

    api.nvim_create_autocmd(
      {
        'BufEnter',
        'BufWinEnter',
        'CursorHold',
        'CursorHoldI',
        'BufWritePost',
        'FileChangedShellPost',
        'BufWritePost',
        'ModeChanged',
        'VimResume'
      },
      {
        callback = function()
          local b = vim.b
          local g = vim.g
          local bo = vim.bo

          if vim.tbl_contains(ft_ignore_git, bo.ft) then
            b.statl_git = nil
            return
          end

          if b.gitsigns_status then
            b.statl_git = b.gitsigns_status == '' and b.gitsigns_head or
                b.gitsigns_head .. ' ' .. b.gitsigns_status
            return
          end

          b.statl_git = g.gitsigns_head and g.gitsigns_head or nil
        end,
        group = api.nvim_create_augroup('gitsigns_user', {}),
      }
    )
  end,
  event = 'VeryLazy'
}

return M
