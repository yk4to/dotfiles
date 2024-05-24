return {
  {
    name = "onedarkpro.nvim",
    dir = "@onedarkpro_nvim@",
    priority = 1000,
    lazy = false,
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true
        }
      })
      vim.cmd("colorscheme onedark")
    end,
  },
}
