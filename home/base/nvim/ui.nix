{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;

      settings = {
        flavour = "mocha";
        transparent_background = true;
        integrations = {
          cmp = true;
          gitsigns = true;
          treesitter = true;
          which_key = true;
        };
      };
    };

    plugins = {
      web-devicons.enable = true;

      lualine = {
        enable = true;

        settings = {
          options = {
            globalstatus = true;
            theme = "catppuccin-nvim";
          };

          sections = {
            lualine_c = ["filename"];
            lualine_x = [
              "diagnostics"
              "encoding"
              "filetype"
            ];
          };
        };
      };

      which-key.enable = true;
    };
  };
}
