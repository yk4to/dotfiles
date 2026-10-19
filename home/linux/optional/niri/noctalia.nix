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
    wayland.windowManager.niri.settings = {
      debug = {
        # Allows notification actions and window activation from Noctalia.
        honor-xdg-activation-with-invalid-serial = {};
      };

      _children = [
        {
          spawn-at-startup = "noctalia";
        }
        {
          window-rule = {
            # Rounded corners for a modern look.
            geometry-corner-radius = 20.0;

            # Clips window contents to the rounded corner boundaries.
            clip-to-geometry = true;
          };
        }
        {
          # Floating Noctalia settings window.
          window-rule = {
            match._props.app-id = "^dev\\.noctalia\\.Noctalia$";
            open-floating = true;
            default-column-width.fixed = 1080;
            default-window-height.fixed = 920;
          };
        }
        {
          # Blurred wallpaper in the overview (requires `backdrop.enabled`).
          layer-rule = {
            match._props.namespace = "^noctalia-backdrop";
            place-within-backdrop = true;
          };
        }
        {
          layer-rule = {
            match._props.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
            background-effect.xray = false;
          };
        }
        {
          layer-rule = {
            match._props.namespace = "^noctalia-window-switcher$";
            background-effect = {
              blur = true;
              xray = false;
            };
          };
        }
      ];
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
          # Replaces the polkit-kde agent previously provided by niri-flake.
          polkit_agent = true;
        };

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
