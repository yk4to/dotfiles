local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = "plugins",
  ui = {
    border = "rounded",
  }
})