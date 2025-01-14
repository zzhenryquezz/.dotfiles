return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        config = function()

            require("render-markdown").setup({})

            vim.keymap.set("n", "<leader>rm", function()
                require("render-markdown").toggle()
            end, { noremap = true, silent = true })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        config = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            -- vim.g.mkdp_browser  = "/mnt/c/Windows/explorer.exe"
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                disable_sync_scroll = 0,
                sync_scroll_type = "middle",
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {},
                content_editable = false,
                disable_filename = 0,
            }

            vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreviewToggle", { desc = "[M]arkdown [P]review" })
        end,
    },
}
