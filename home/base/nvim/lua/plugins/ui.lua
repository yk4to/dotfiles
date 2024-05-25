-- ref: https://qiita.com/uhooi/items/99aeff822d4870a8e269
local lsp_names = function()
  local clients = {}
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if client.name == "null-ls" then
      local sources = {}
      for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
        table.insert(sources, source.name)
      end
      table.insert(clients, "null-ls(" .. table.concat(sources, ", ") .. ")")
    else
      table.insert(clients, client.name)
    end
  end
  if next(clients) then
    return " " .. table.concat(clients, ", ")
  else
    return " No LSP"
  end
end

return {
  {
    name = "lualine.nvim",
    dir = "@lualine_nvim@",
    dependencies = { { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" } },
    opts = {
      options = {
        theme = "onedark",
        globalstatus = true,
      },
      sections = {
        lualine_x = { 'encoding', 'fileformat', 'filetype', lsp_names },
      },
    },
  },
  {
    name = "barbar.nvim",
    dir = "@barbar_nvim@",
    dependencies = {
      { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
      { name = "gitsigns.nvim",     dir = "@gitsigns_nvim@" },
    },
    event = "VeryLazy",
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require("barbar").setup()
    end,
  },
  {
    name = "fidget.nvim",
    dir = "@fidget_nvim@",
    config = function()
      require("fidget").setup()
    end,
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
  },
  {
    name = "nvim-notify",
    dir = "@nvim_notify@",
    opts = {
      background_colour = "#000000",
    }
  },
}
