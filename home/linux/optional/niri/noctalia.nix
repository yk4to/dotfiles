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

      window-rule = {
        # Rounded corners for a modern look.
        geometry-corner-radius = 20;

        # Clips window contents to the rounded corner boundaries.
        clip-to-geometry = true;
      };

      debug = {
        # Allows notification actions and window activation from Noctalia.
        honor-xdg-activation-with-invalid-serial = true;
      };
    };

    programs.noctalia-shell = {
      enable = true;

      settings = {
        colorSchemes.predefinedScheme = "Monochrome";
        # general = {
        #   avatarImage = "/home/drfoobar/.face";
        #   radiusRatio = 0.2;
        # };
        location = {
          monthBeforeDay = true;
          name = "Tokyo, Japan";
        };
      };
    };
  };
}
