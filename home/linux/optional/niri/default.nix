{
  config,
  inputs,
  lib,
  mylib,
  pkgs,
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
    programs.niri = {
      package = pkgs.niri-unstable;
      settings = {
        xwayland-satellite = {
          enable = true;
          path = getExe pkgs.xwayland-satellite-unstable;
        };

        environment = {
          NIXOS_OZONE_WL = "1";
          QT_QPA_PLATFORMTHEME = "gtk3";
        };

        cursor.theme = "catppuccin-mocha-blue-cursors";

        outputs."eDP-1".scale = 1.1;

        input.touchpad.natural-scroll = false;

        gestures.hot-corners.enable = false;

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
