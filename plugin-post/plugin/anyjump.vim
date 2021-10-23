lua <<EOF
vim.g.any_jump_disable_default_keybindings = 1
vim.g.any_jump_window_width_ratio = 0.8
vim.g.any_jump_window_height_ratio = 0.85
vim.g.any_jump_window_top_offset = 3

vim.g.any_jump_colors = {
  plain_text = 'Comment',
  preview = 'Comment',
  preview_keyword = 'Operator',
  heading_text = 'Function',
  heading_keyword = 'Identifier',
  group_text = 'Comment',
  group_name = 'Function',
  more_button = 'Operator',
  more_explain = 'Comment',
  result_line_number = 'Comment',
  result_text = 'Statement',
  result_path = 'String',
  help = 'Comment'
}
EOF

" nnoremap <leader>aj :AnyJump<CR>
" xnoremap <leader>aj :AnyJumpVisual<CR>
" nnoremap <leader>aa :AnyJumpArg 
" nnoremap <leader>al :AnyJumpLastResults<CR>
