return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "jsonls",
                    "tsserver",
                    "html",
                    "volar",
                },
                automatic_installtion = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local util = require 'lspconfig.util'

            local function get_typescript_server_path(root_dir)
                local global_ts = '/home/henryque/.asdf/installs/nodejs/20.15.0/lib/node_modules/typescript/lib'
                local found_ts = ''
                local function check_dir(path)
                    found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
                    if vim.loop.fs_stat(found_ts) then
                        return path
                    end
                end
                if util.search_ancestors(root_dir, check_dir) then
                    return found_ts
                else
                    return global_ts
                end
            end

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })

            lspconfig.tsserver.setup({
                root_dir = function(fname)
                    local util = require("lspconfig.util")
                    return util.root_pattern(".git")(fname)
                        or util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
                end,
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location =
                            "/home/henryque/.asdf/installs/nodejs/20.15.0/lib/node_modules/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            })

            lspconfig.volar.setup({
                capabilities = capabilities,
                on_new_config = function(new_config, new_root_dir)
                    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
                end,
            })

            lspconfig.eslint.setup({
                capabilities,
                root_dir = function(fname)
                    local util = require("lspconfig.util")
                    return util.root_pattern(".git")(fname)
                        or util.root_pattern("package.json")(fname)
                end,
                on_attach = function(_client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, {})
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
        end,
    },
}
