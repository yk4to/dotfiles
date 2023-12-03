return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem.filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          -- ".DS_Store",
          -- "thumbs.db",
        },
      }
      opts.filesystem.bind_to_cwd = true
      opts.filesystem.cwd_target = { sidebar = "global" }
      opts.default_component_configs.icon = {
        folder_closed = "󰉋",
        folder_open = "󰝰",
        folder_empty = "󰉖",
        default = "*",
        highlight = "NeoTreeFileIcon",
      }
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        silent_chdir = false,
        show_hidden = true,
        detection_methods = { "pattern" },
      })
    end,
  },
}
