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
    on_new_config = function(config)
        vim.notify("eslint on_new_config called", vim.log.levels.INFO)
        -- if global variable is set, use it as root_dir
        if vim.g.eslint_node_path then
            config.cmd_env = { NODE_PATH = vim.g.eslint_node_path }
            vim.notify("eslint using global node path: " .. vim.g.eslint_node_path, vim.log.levels.INFO)
        else
            vim.notify("eslint using default node path", vim.log.levels.INFO)
        end

    end,
})

vim.lsp.enable("eslint")
