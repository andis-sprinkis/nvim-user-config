lua <<EOF
local autoload_plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.filereadable(autoload_plug_path) == false then
  vim.cmd('!curl -fLo ' .. autoload_plug_path .. '  --create-dirs "https://raw.githubusercontent.com/andis-sprinkis/vim-plug/master/plug.vim"')
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end
EOF
