{
  inputs,
  lib,
  config,
  ...
}: let
  wallpaperPath = "${inputs.private-assets}/wallpapers/checkmate.png";
  wallpaperDirectory = "${inputs.private-assets}/wallpapers";
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf config.optionalModules.linux.niri.enable {
    programs.niri.settings = {
      spawn-at-startup = [
        {
          command = [
            "noctalia"
          ];
        }
      ];

      window-rules = [
        {
          # Rounded corners for a modern look.
          geometry-corner-radius = {
            bottom-left = 20.0;
            bottom-right = 20.0;
            top-left = 20.0;
            top-right = 20.0;
          };

          # Clips window contents to the rounded corner boundaries.
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "dev.noctalia.Noctalia.Settings";
            }
          ];
          open-floating = true;
          default-column-width = {
            fixed = 1080;
          };
          default-window-height = {
            fixed = 920;
          };
        }
      ];

      layer-rules = [
        {
          matches = [
            {
              namespace = "^noctalia-backdrop";
            }
          ];
          place-within-backdrop = true;
        }
      ];

      debug = {
        # Allows notification actions and window activation from Noctalia.
        honor-xdg-activation-with-invalid-serial = [];
      };
    };

    programs.noctalia = {
      enable = true;

      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        shell = {
          avatar_path = "${../../../../icon.jpg}";
        };

        wallpaper = {
          enabled = true;
          directory = wallpaperDirectory;
          default.path = wallpaperPath;
        };

        backdrop = {
          enabled = true;
          blur_intensity = 0.5;
          tint_intensity = 0.3;
        };

        location = {
          address = "Tokyo, Japan";
        };

        notification = {
          enable_daemon = true;
        };

        bar = {
          order = ["main"];

          main = {
            start = [
              "launcher"
              "workspaces"
              "cpu"
              "media"
            ];
            center = [
              "active_window"
            ];
            end = [
              "tray"
              "notifications"
              "power_profile"
              "battery"
              "volume"
              "brightness"
              "caffeine"
              "clock"
              "control-center"
            ];
          };
        };

        widget = {
          clock = {
            format = "{:%Y/%m/%d (%a) %H:%M}";
            tooltip_format = "{:%Y/%m/%d (%a) %H:%M}";
          };

          cpu = {
            type = "sysmon";
            stat = "cpu_usage";
            show_label = false;
          };

          media = {
            hide_when_no_media = true;
            title_scroll = "on_hover";
          };

          notifications = {
            hide_when_no_unread = true;
          };
        };
      };
    };
  };
}
