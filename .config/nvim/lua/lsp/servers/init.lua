local servers = {
    'lua',
    'python',
}

for _, server in ipairs(servers) do
    require('lsp.servers.' .. server)
end
