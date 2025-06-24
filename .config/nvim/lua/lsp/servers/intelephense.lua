local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local find_root = util.root_pattern(".git")
local cwd = vim.fn.getcwd()

lspconfig.intelephense.setup({
    capabilities = capabilities,
    root_dir = function(fname)
        local result = find_root(fname) or cwd 

        vim.notify("Intelephense root directory: " .. result, vim.log.levels.INFO)

        return result
    end,
    settings = {
        intelephense = {
            environment = {
                documentRoot = cwd,
                includePaths = {
                    cwd .. "/vendor",
                },
            },
        },
    },
})
