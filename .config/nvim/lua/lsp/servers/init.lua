local servers = {
    'lua',
    'python',
    'ts_ls',
    'volar',
    'eslint',
}

for _, server in ipairs(servers) do
    require('lsp.servers.' .. server)
end
