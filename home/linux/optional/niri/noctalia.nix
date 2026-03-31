{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf config.optionalModules.linux.niri.enable {
    programs.niri.settings = {
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
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
      ];

      layer-rules = [
        {
          matches = [
            {
              namespace = "^noctalia-overview*";
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

    programs.noctalia-shell = {
      enable = true;

      settings = {
        colorSchemes.predefinedScheme = "Catppuccin";

        general.avatarImage = "${../../../../icon.jpg}";

        wallpaper.overviewEnabled = true;

        location.name = "Tokyo, Japan";

        appLauncher.terminalCommand = "ghostty --window-decoration=false";

        bar = {
          widgets = {
            left = [
              {
                id = "Launcher";
                useDistroLogo = true;
                enableColorization = true;
              }
              {
                id = "Workspace";
              }
              {
                id = "SystemMonitor";
                compactMode = true;
              }
              {
                id = "MediaMini";
              }
            ];
            center = [
              {
                id = "ActiveWindow";
              }
            ];
            right = [
              {
                id = "Tray";
                drawerEnabled = false;
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
                showPowerProfiles = true;
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "KeepAwake";
              }
              {
                id = "Clock";
                formatHorizontal = "yyyy/MM/dd (ddd) HH:mm";
                tooltipFormat = "yyyy/MM/dd (ddd) HH:mm";
              }
              {
                id = "ControlCenter";
              }
            ];
          };
        };

        controlCenter = {
          cards = [
            {
              id = "profile-card";
              enabled = true;
            }
            {
              id = "shortcuts-card";
              enabled = true;
            }
            {
              id = "audio-card";
              enabled = true;
            }
            {
              id = "brightness-card";
              enabled = false;
            }
            {
              id = "weather-card";
              enabled = false;
            }
            {
              id = "media-sysmon-card";
              enabled = false;
            }
          ];
        };
      };
    };
  };
}
