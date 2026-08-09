return {
    { "williamboman/mason.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("mason").setup({
                -- PATH = "prepend"
            })

            require("mason-lspconfig").setup({
                automatic_enable = false,
            })

            require("mason-tool-installer").setup({
                ensure_installed = {
                    "lua_ls",
                    "jsonls",
                    "ts_ls",
                    "html",
                    "vue_ls",
                    "eslint",
                    "yamlls",
                    "terraformls",
                    "stylua",
                    "pyright",
                    "intelephense",
                },
            })

            -- import all the lsp servers in languages folders
            require("lsp.servers")

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
            vim.diagnostic.config({
                virtual_text = {
                    source = true,
                    format = function(diagnostic)
                        if diagnostic.user_data and diagnostic.user_data.code then
                            return string.format("%s %s", diagnostic.user_data.code, diagnostic.message)
                        else
                            return diagnostic.message
                        end
                    end,
                },
                signs = true,
                float = {
                    header = "Diagnostics",
                    source = true,
                    border = "rounded",
                },
            })
        end,
    },
}
