lua <<EOF
-- tsconfig.json is actually jsonc
vim.api.nvim_exec([[
au BufRead,BufNewFile tsconfig.json setlocal filetype=jsonc
]], true)
EOF
