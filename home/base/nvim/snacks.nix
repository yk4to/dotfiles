{config, ...}: let
  helpers = config.lib.nixvim;
in {
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      autoLoad = true;

      settings = {
        dashboard = {
          enabled = true;
          sections = [
            {section = "header";}
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Recent Files";
              section = "recent_files";
              indent = 2;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Projects";
              section = "projects";
              indent = 2;
              padding = 1;
            }
          ];
        };
        explorer = {
          enabled = true;
          replace_netrw = true;
        };
        indent.enabled = true;
        input.enabled = true;
        lazygit.enabled = true;
        notifier.enabled = true;
        picker.enabled = true;
        terminal.enabled = true;
      };
    };

    keymaps = [
      {
        key = "<leader>e";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            Snacks.explorer.open()
          end
        '';
        options.desc = "Open explorer";
      }
      {
        key = "<leader>gg";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            Snacks.lazygit.open()
          end
        '';
        options.desc = "Open lazygit";
      }
      {
        key = "<leader>tt";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            Snacks.terminal()
          end
        '';
        options.desc = "Toggle terminal";
      }
    ];
  };
}
