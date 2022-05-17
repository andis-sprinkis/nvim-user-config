return function()
  require('qf_helper').setup({
    prefer_loclist = true, -- Used for QNext/QPrev (see Commands below)
    sort_lsp_diagnostics = true, -- Sort LSP diagnostic results
    quickfix = {
      autoclose = true, -- Autoclose qf if it's the only open window
      default_bindings = false, -- Set up recommended bindings in qf window
      default_options = true, -- Set recommended buffer and window options
      max_height = 15, -- Max qf height when using open() or toggle()
      min_height = 1, -- Min qf height when using open() or toggle()
      track_location = 'cursor', -- Keep qf updated with your current location
      -- Use `true` to update position as well
    },
    loclist = { -- The same options, but for the loclist
      autoclose = true,
      default_bindings = false,
      default_options = true,
      max_height = 15,
      min_height = 1,
      track_location = 'cursor',
    },
  })

  vim.cmd([[
    " " use <C-N> and <C-P> for next/prev.
    " nnoremap <silent> <C-N> <cmd>QNext<CR>
    " nnoremap <silent> <C-P> <cmd>QPrev<CR>
    " " toggle the quickfix open/closed without jumping to it
    " nnoremap <silent> <leader>q <cmd>QFToggle!<CR>
    " nnoremap <silent> <leader>l <cmd>LLToggle!<CR>

    " CTRL-s opens selection in horizontal split
    autocmd FileType qf lua vim.api.nvim_buf_set_keymap(0,"n","<C-s>",'<cmd>lua require"qf_helper".open_split("split")<CR>',{ noremap = true, silent = true })
    " CTRL-v opens selection in vertical split
    autocmd FileType qf lua vim.api.nvim_buf_set_keymap(0, "n", "<C-v>", '<cmd>lua require"qf_helper".open_split("vsplit")<CR>', { noremap = true, silent = true })
    " p jumps without leaving quickfix
    autocmd FileType qf lua vim.api.nvim_buf_set_keymap(0, "n", "<C-p>", "<CR><C-W>p", { noremap = true, silent = true })
    " <C-k> scrolls up and jumps without leaving quickfix
    autocmd FileType qf lua vim.api.nvim_buf_set_keymap(0, "n", "<S-k>", "k<CR><C-W>p", { noremap = true, silent = true })
    " <C-j> scrolls down and jumps without leaving quickfix
    autocmd FileType qf lua vim.api.nvim_buf_set_keymap(0, "n", "<S-j>", "j<CR><C-W>p", { noremap = true, silent = true })
    " { and } navigates up and down by file
    autocmd FileType qf lua vim.api.nvim_buf_set_keymap( 0, "n", "{", '<cmd>lua require"qf_helper".navigate(-1, {by_file = true})<CR><C-W>p', { noremap = true, silent = true })
    autocmd FileType qf lua vim.api.nvim_buf_set_keymap( 0, "n", "}", '<cmd>lua require"qf_helper".navigate(1, {by_file = true})<CR><C-W>p', { noremap = true, silent = true })
  ]])
end
