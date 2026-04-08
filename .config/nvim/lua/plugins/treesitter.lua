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

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
