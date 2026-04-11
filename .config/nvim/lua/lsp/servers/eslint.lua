local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require("lspconfig.util")

local base_on_attach = vim.lsp.config.eslint.on_attach

vim.lsp.config("eslint", {
    capabilities = capabilities,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
        "html",
        "twig",
        "css",
    },
    root_dir = util.root_pattern(
        "eslint.config.ts",
        "eslint.config.js",
        "eslint.config.mjs",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml"
    ),
    on_attach = function(client, bufnr)
        if not base_on_attach then
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
