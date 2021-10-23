lua <<EOF
-- tsconfig.json is actually jsonc
vim.cmd('au BufRead,BufNewFile tsconfig.json setlocal filetype=jsonc')
EOF
