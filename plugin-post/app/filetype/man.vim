lua <<EOF
vim.api.nvim_exec([[
au FileType man setlocal signcolumn=no
]], true)
EOF
