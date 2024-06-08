return {
  {
    name = "project.nvim",
    dir = "@project_nvim@",
    config = function()
      require("project_nvim").setup({
        silent_chdir = false,
        show_hidden = true,
        detection_methods = { "pattern" },
      })
    end,
  },
  {
    name = "neo-tree.nvim",
    dir = "@neo_tree_nvim@",
    dependencies = {
      { name = "nui.nvim",          dir = "@nui_nvim@" },
      { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
      { name = "plenary.nvim",      dir = "@plenary_nvim@" },
    },
    cmd = "Neotree",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            -- ".DS_Store",
            -- "thumbs.db",
          },
        },
        bind_to_cwd = true,
        cwd_target = { sidebar = "global" },
      },
      default_component_configs = {
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "󰉖",
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
  },
  {
    name = "telescope.nvim",
    dir = "@telescope_nvim@",
    dependencies = { name = "plenary.nvim", dir = "@plenary_nvim@" },
    cmd = "Telescope",
    keys = { "<leader>f" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

      telescope.setup()
    end,
  },
  {
    name = "gitsigns",
    dir = "@gitsigns_nvim@",
    event = "BufRead",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    name = "nvim-colorizer.lua",
    dir = "@nvim_colorizer_lua@",
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
  {
    name = "which-key.nvim",
    dir = "@which_key_nvim@",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  {
    name = "toggleterm.nvim",
    dir = "@toggleterm_nvim@",
    event = "VeryLazy",
    keys = {
      {
        "<leader>tv",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 0, vim.loop.cwd(), "vertical")
        end,
        desc = "ToggleTerm (vertical)",
      },
      {
        "<leader>th",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 10, vim.loop.cwd(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal)",
      },
    },
  }
}