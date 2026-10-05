{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
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
          # Floating Noctalia settings window.
          matches = [
            {
              app-id = "^dev\\.noctalia\\.Noctalia$";
            }
          ];
          open-floating = true;
          default-column-width.fixed = 1080;
          default-window-height.fixed = 920;
        }
      ];

      layer-rules = [
        {
          # Blurred wallpaper in the overview (requires `backdrop.enabled`).
          matches = [
            {
              namespace = "^noctalia-backdrop";
            }
          ];
          place-within-backdrop = true;
        }
        {
          matches = [
            {
              namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
            }
          ];
          background-effect.xray = false;
        }
        {
          matches = [
            {
              namespace = "^noctalia-window-switcher$";
            }
          ];
          background-effect = {
            blur = true;
            xray = false;
          };
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

        shell.avatar_path = "${../../../../icon.jpg}";

        wallpaper = {
          directory = wallpaperDirectory;
          default.path = "${wallpaperDirectory}/checkmate.png";
        };

        backdrop.enabled = true;

        location.address = "Tokyo, Japan";

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
          launcher = {
            custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
            custom_image_colorize = true;
          };

          cpu = {
            type = "sysmon";
            stat = "cpu_usage";
          };

          media = {
            hide_when_no_media = true;
            title_scroll = "on_hover";
          };

          clock = {
            format = "{:%Y/%m/%d (%a) %H:%M}";
            tooltip_format = "{:%Y/%m/%d (%a) %H:%M}";
          };
        };
      };
    };
  };
}
