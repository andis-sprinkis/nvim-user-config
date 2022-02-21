local lsp_installer = require "nvim-lsp-installer"

-- Include the servers you want to have installed by default below

for _, name in pairs(require('lsp_servers').servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print('Installing ' .. name)
    server:install()
  end
end

