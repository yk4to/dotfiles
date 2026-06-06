{
  programs.nixvim = {
    plugins = {
      comment.enable = true;

      gitsigns = {
        enable = true;

        settings.signs = {
          add.text = "│";
          change.text = "│";
          changedelete.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          untracked.text = "│";
        };
      };

      nvim-autopairs = {
        enable = true;

        settings.check_ts = true;
      };
    };

    keymaps = [
      {
        key = "]h";
        mode = "n";
        action = "<cmd>Gitsigns next_hunk<cr>";
        options.desc = "Next hunk";
      }
      {
        key = "[h";
        mode = "n";
        action = "<cmd>Gitsigns prev_hunk<cr>";
        options.desc = "Previous hunk";
      }
      {
        key = "<leader>gp";
        mode = "n";
        action = "<cmd>Gitsigns preview_hunk_inline<cr>";
        options.desc = "Preview hunk";
      }
      {
        key = "<leader>gs";
        mode = "n";
        action = "<cmd>Gitsigns stage_hunk<cr>";
        options.desc = "Stage hunk";
      }
      {
        key = "<leader>gu";
        mode = "n";
        action.__raw = ''
          function()
            local bufnr = vim.api.nvim_get_current_buf()
            local line = vim.api.nvim_win_get_cursor(0)[1]
            local placed = vim.fn.sign_getplaced(bufnr, {
              group = "gitsigns_signs_staged",
              lnum = line,
            })
            local staged_signs = placed[1] and placed[1].signs or {}

            if #staged_signs > 0 then
              require("gitsigns").stage_hunk()
            else
              require("gitsigns").reset_hunk()
            end
          end
        '';
        options.desc = "Unstage or reset hunk";
      }
      {
        key = "<leader>gb";
        mode = "n";
        action = "<cmd>Gitsigns blame_line<cr>";
        options.desc = "Blame line";
      }
      {
        key = "<leader>gB";
        mode = "n";
        action = "<cmd>Gitsigns toggle_current_line_blame<cr>";
        options.desc = "Toggle blame";
      }
      {
        key = "<leader>gd";
        mode = "n";
        action = "<cmd>Gitsigns diffthis<cr>";
        options.desc = "Diff this";
      }
    ];
  };
}
