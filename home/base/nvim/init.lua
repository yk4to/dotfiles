vim.g.mapleader = " "

vim.opt.number = true

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- disable allow keys
vim.api.nvim_set_keymap('i', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Right>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<BS>', '<Nop>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<BS>', '<Nop>', { noremap = true, silent = true })

local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = "plugins",
  ui = {
    border = "rounded",
  }
})