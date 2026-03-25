{
  config,
  inputs,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.niri;
in {
  imports = mylib.scanPaths ./.;

  options.optionalModules.linux.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri-flake.overlays.niri];

    programs.niri = {
      package = pkgs.niri-unstable;
      settings = {
        xwayland-satellite = {
          enable = true;
          path = getExe pkgs.xwayland-satellite-unstable;
        };

        environment."NIXOS_OZONE_WL" = "1";

        outputs."eDP-1".scale = 1.1;

        input.touchpad.natural-scroll = false;

        window-rules = [
          {
            matches = [
              {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
          }
        ];
      };
    };
  };
}
