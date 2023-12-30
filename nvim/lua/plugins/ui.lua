return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
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
      table.insert(opts.sections.lualine_x, lsp_names)
      opts.sections.lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 1 } },
      }
      opts.sections.lualine_z = {
        "location",
      }
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPre" },
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    opts = function()
      local color = require("onedarkpro.helpers")
      local colors = color.get_colors()
      
      return {
        handle = {
          color = colors.line_number,
        },
        marks = {
          Search = { color = colors.cyan },
          Error = { color = colors.red },
          Warn = { color = colors.yellow },
          Info = { color = colors.green },
          Hint = { color = colors.blue },
          Misc = { color = colors.purple },
        },
        handlers = {
          search = true,
        },
      }
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre" },
    opts = {
      filetypes = {
        "*",
        "!lazy",
      },
      user_default_options = {
        names = false,
      },
    },
  },
}
