if vim.g.os == nil then
  if (vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 or vim.fn.has('win16') == 1) then
    vim.g.os = 'Windows'
  else
    vim.g.os = vim.fn.substitute(vim.fn.system('uname'), '\n', '', '')
  end
end
