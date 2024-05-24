return {
  {
    name = "lualine.nvim",
    dir = "@lualine_nvim@",
    dependencies = { { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" } },
    opts = {
      theme = "onedark",
    }
  },
  {
    name = "noice.nvim",
    dir = "@noice_nvim@",
    event = "VeryLazy",
    dependencies = {
      { name = "nui.nvim",    dir = "@nui_nvim@" },
      { name = "nvim-notify", dir = "@nvim_notify@" },
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
    },
  }
}