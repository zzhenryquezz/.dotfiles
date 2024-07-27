vim.cmd("set nu")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set smarttab")
vim.cmd("set smartindent")
vim.cmd("set signcolumn=yes")
vim.cmd("set mouse=")

vim.keymap.set("t", "<Esc>", '<C-\\><C-n><CR>')


require("config.lazy")
