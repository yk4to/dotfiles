return {
  {
    name = "onedarkpro.nvim",
    dir = "@onedarkpro_nvim@",
    priority = 1000,
    opts = function()
      vim.cmd("colorscheme onedark")
    end,
  },
}
