return {
    { "williamboman/mason.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer" },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup({
                -- PATH = "prepend"
            })

            require("mason-lspconfig").setup()
            require('mason-tool-installer').setup({
                ensure_installed = {
                    "lua_ls",
                    "jsonls",
                    "ts_ls",
                    "html",
                    "volar",
                    "eslint",
                    "yamlls",
                    "terraformls",
                    "stylua",
                    "pyright"
                },
            })

        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local util = require 'lspconfig.util'

            -- import all the lsp servers in languages folders  
            require('lsp.servers')

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()


            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })

            -- lspconfig.eslint.setup({
            --     capabilities,
            --     root_dir = util.root_pattern("eslint.config.js", "eslint.config.mjs", ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml"),
            --     on_attach = function(_client, bufnr)
            --         vim.api.nvim_create_autocmd("BufWritePre", {
            --             buffer = bufnr,
            --             command = "EslintFixAll",
            --         })
            --     end,
            -- })

            lspconfig.yamlls.setup({
                capabilities = capabilities,
                on_attach = function(client)
                    client.server_capabilities.documentFormattingProvider = true
                end,
                settings = {
                    yaml = {
                        format = {
                            enable = true,
                        },
                        schemaStore = {
                            enable = true,
                        },
                    },
                    editor = {
                        tabSize = 4,
                    },
                },
            })

            lspconfig.terraformls.setup({
                capabilities = capabilities,
            })

            lspconfig.intelephense.setup({
                capabilities = capabilities,
            })

            lspconfig.html.setup({
                capabilities = capabilities,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, {})
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
		    vim.keymap.set("n", "<leader>gf", function()
                vim.lsp.buf.format({
                    formatting_options = {
                        tabSize = vim.bo.tabstop,
                    },
                })
            end)
        end,
    },
}
