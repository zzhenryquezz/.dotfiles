vim.cmd("set nu")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set smarttab")
vim.cmd("set smartindent")
vim.cmd("set signcolumn=yes")
vim.cmd("set mouse=")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set spelllang=en_us")
vim.cmd("set spell")


vim.keymap.set("t", "<Esc>", '<C-\\><C-n><CR>')


require("config.lazy")
