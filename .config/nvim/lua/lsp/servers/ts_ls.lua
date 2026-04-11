local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("ts_ls", {
    root_dir = function(fname)
        return  lspconfig.util.root_pattern("tsconfig.json")(fname)
            or lspconfig.util.root_pattern(".git")(fname)
            or lspconfig.util.root_pattern("package.json")(fname)
            or vim.fn.getcwd()
    end,
    capabilities = capabilities,
    init_options = {
        diagnostics = {
            ignoredCodes = { 80001 }, -- example code, replace with actual warning code for commonjs warning
        },
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vim.fn.stdpath("data")
                    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                -- location = lspconfig.util.path.join(
                -- 	utils.get_global_node_modules_path(),
                -- 	"node_modules/@vue/typescript-plugin"
                -- ),
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
