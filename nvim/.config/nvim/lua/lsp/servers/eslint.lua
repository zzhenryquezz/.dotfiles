local capabilities = require("cmp_nvim_lsp").default_capabilities()
local base_on_attach = vim.lsp.config.eslint.on_attach

vim.lsp.config("eslint", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        if not base_on_attach then
            -- show warning if base_on_attach is not defined 
            vim.notify("eslint on_attach is not defined, skipping eslint auto-fix on save", vim.log.levels.WARN)
            return
        end

        base_on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "LspEslintFixAll",
        })
    end,
})

vim.lsp.enable("eslint")
