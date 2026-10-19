{
  config,
  mylib,
  hostConfig,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.niri;
  displays = hostConfig.displays or [];
  mkNiriDisplayOutput = display: {
    output = {
      _args = [display.connector];
      scale = mylib.display.getScale display;
    };
  };
in {
  options.optionalModules.linux.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.niri = {
      enable = true;

      # Session units and portals are provided by the NixOS module (programs.niri).
      systemd.enable = false;
      portalPackage = null;

      settings = {
        environment = {
          NIXOS_OZONE_WL = "1";
          QT_QPA_PLATFORMTHEME = "gtk3";
        };

        cursor.xcursor-theme = "catppuccin-mocha-mauve-cursors";

        input.touchpad.tap = {};

        # Let windows pick their initial width instead of niri's default of 0.5.
        layout.default-column-width = {};

        gestures.hot-corners.off = {};

        blur = {
          passes = 2;
          offset = 3.0;
          noise = 0.03;
          saturation = 1.0;
        };

        _children =
          [
            {
              window-rule.background-effect = {
                blur = true;
                xray = false;
              };
            }
            {
              window-rule = {
                match._props = {
                  app-id = "^zen-beta$";
                  title = "^Picture-in-Picture$";
                };
                open-floating = true;
              };
            }
            {
              window-rule = {
                match._props.app-id = "com.mitchellh.ghostty";
                draw-border-with-background = false;
              };
            }
          ]
          # [{ connector = "eDP-1"; resolution = { width = 1920; height = 1080; }; inch = 13.3; is_laptop = true; }] ->
          # output "eDP-1" { scale 1.304190; }
          ++ map mkNiriDisplayOutput displays;
      };
    };
  };
}
