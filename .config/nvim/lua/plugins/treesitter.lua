return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
        local treesitter = require("nvim-treesitter")
        local ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "python",
            "typescript",
            "javascript",
            "html",
            "css",
            "json",
            "yaml",
            "bash",
            "markdown",
        }

        treesitter.install(ensure_installed):wait(300000)

        -- local configs = require("nvim-treesitter.configs")
        -- configs.setup({
        -- 	auto_install = true,
        -- 	sync_install = false,
        -- 	highlight = { enable = true },
        -- 	ensure_installed = ensure_installed,
        -- })
    end,
}
