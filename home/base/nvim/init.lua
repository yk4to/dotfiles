vim.g.mapleader = " "

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

vim.opt.list = true
vim.opt.completeopt = "menu,menuone,noselect"

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

-- terminal
local function float_term(cmd)
	local opts = { size = { width = 0.9, height = 0.9 } }
	require("lazy.util").float_term(cmd, opts)
end

vim.keymap.set("n", "<Leader>gg", function()
	float_term({ "lazygit" })
end)

-- setup lazy.nvim
local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = "plugins",
  ui = {
    border = "rounded",
  }
})
