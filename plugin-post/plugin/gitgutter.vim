lua <<EOF
vim.g.gitgutter_override_sign_column_highlight = 1
vim.cmd('au BufWritePost,WinEnter * GitGutter')
EOF
