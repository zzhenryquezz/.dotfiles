return {
  'stevearc/overseer.nvim',
  config = function(_, opts)
    local overseer = require("overseer")

    overseer.setup(opts)
  end,
}
