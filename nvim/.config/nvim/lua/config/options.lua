vim.cmd("set nu")

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set smarttab")
vim.cmd("set expandtab")
vim.cmd("set smartindent")
vim.cmd("set autoindent")

vim.cmd("set signcolumn=yes")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.cmd("set list")

vim.cmd("set mouse=")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99

-- vim.cmd("set spelllang=en_us,pt_br")
-- vim.cmd("set spell")
-- vim.cmd("set spellcapcheck=") -- Ignora partes de camelCase
--
-- vim.opt.spelloptions:append("camel") -- Ignora partes de camelCase
--
