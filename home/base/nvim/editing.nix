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
        key = "<leader>gb";
        mode = "n";
        action = "<cmd>Gitsigns blame_line<cr>";
        options.desc = "Blame line";
      }
    ];
  };
}
