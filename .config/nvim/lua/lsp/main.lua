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
            -- import all the lsp servers in languages folders  
            require('lsp.servers')

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
