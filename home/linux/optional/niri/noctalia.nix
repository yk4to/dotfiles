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

      debug = {
        # Allows notification actions and window activation from Noctalia.
        honor-xdg-activation-with-invalid-serial = [];
      };
    };

    programs.noctalia-shell = {
      enable = true;

      settings = {
        colorSchemes.predefinedScheme = "One";

        general.avatarImage = "${../../../../icon.jpg}";

        location = {
          monthBeforeDay = true;
          name = "Tokyo, Japan";
        };

        appLauncher.terminalCommand = "ghostty --window-decoration=false";
      };
    };
  };
}
