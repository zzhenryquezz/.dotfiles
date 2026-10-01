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
            "markdown_inline",
            "vue"
        }

        treesitter.install(ensure_installed):wait(300000)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(args)
                vim.api.nvim_buf_call(args.buf, function()
                    vim.fn.matchadd("MarkdownDirective", "^\\s*:::\\w\\+")
                    vim.fn.matchadd("MarkdownDirective", "^\\s*:::$")
                end)
            end,
        })

        vim.api.nvim_set_hl(0, "MarkdownDirective", {
            link = "Keyword",
        })
    end,
}
