return {
  --[[{"rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
    end,
  },]]
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- ref: https://qiita.com/uhooi/items/99aeff822d4870a8e269
      local lsp_names = function()
        local clients = {}
        for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
          --[[if client.name == 'null-ls' then
            local sources = {}
            for _, source in ipairs(require('null-ls.sources').get_available(vim.bo.filetype)) do
              table.insert(sources, source.name)
            end
            table.insert(clients, 'null-ls(' .. table.concat(sources, ', ') .. ')')
          else]]
          table.insert(clients, client.name)
          --end
        end
        if next(clients) then
          return " " .. table.concat(clients, ", ")
        else
          return " No LSP"
        end
      end
      table.insert(opts.sections.lualine_x, lsp_names)
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
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      return {
        handle = {
          color = mocha.surface2,
        },
        marks = {
          Search = { color = mocha.rosewater },
          Error = { color = mocha.red },
          Warn = { color = mocha.yellow },
          Info = { color = mocha.green },
          Hint = { color = mocha.sapphire },
          Misc = { color = mocha.lavender },
        },
        handlers = {
          search = true,
        },
      }
    end,
  },
}
