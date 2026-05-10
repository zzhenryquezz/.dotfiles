return {
  'stevearc/overseer.nvim',
  config = function(_, opts)
    local overseer = require("overseer")

    overseer.setup(opts)

    vim.keymap.set("n", "<leader>or", function()
        -- call :OverseerRun 
        vim.cmd("OverseerRun")
    end)

    vim.keymap.set("n", "<leader>o", function()
        overseer.toggle()
    end)
  end,
}
