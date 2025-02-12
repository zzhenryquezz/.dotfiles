return {
    { "williamboman/mason.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer" },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup()
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
                    "markdownlint"
                },
            })

        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local util = require 'lspconfig.util'

            local function get_global_node_modules_path()
                local handle = io.popen("npm root -g")

                local global_node_modules = handle:read("*a"):gsub("%s+", "")

                handle:close()

                return global_node_modules
            end


            local function get_typescript_server_path(root_dir)
                local global_ts = util.path.join(get_global_node_modules_path(), 'typescript', 'lib')

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

            lspconfig.ts_ls.setup({
                root_dir = function(fname)
                    return util.root_pattern(".git")(fname)
                        or util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
                end,
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = util.path.join(get_global_node_modules_path(),
                                "node_modules/@vue/typescript-plugin"),
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
                root_dir = util.root_pattern("eslint.config.js", "eslint.config.mjs"),
                on_attach = function(_client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })

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
