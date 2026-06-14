{
  config,
  inputs,
  mylib,
  hostConfig,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.niri;
  displays = hostConfig.displays or [];
  mkNiriDisplayOutputs = display: {
    "${display.connector}".scale = mylib.display.getScale display;
  };
  niriBlurPatch = let
    inherit (inputs.niri-flake.lib.internal) validated-config-for;
    inherit (config.programs.niri) finalConfig package;
  in
    lib.mkForce (
      validated-config-for pkgs package ''
        ${finalConfig}

        blur {
          passes 2
          offset 3.0
          noise 0.03
          saturation 1.0
        }

        window-rule {
          background-effect {
            blur true
            xray false
          }
        }

        layer-rule {
          match namespace="^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
          background-effect {
            xray false
          }
        }
      ''
    );
in {
  options.optionalModules.linux.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable {
    programs.niri = {
      package = pkgs.niri-unstable;
      settings =
        {
          xwayland-satellite = {
            enable = true;
            path = getExe pkgs.xwayland-satellite-unstable;
          };

          environment = {
            NIXOS_OZONE_WL = "1";
            QT_QPA_PLATFORMTHEME = "gtk3";
          };

          cursor.theme = "catppuccin-mocha-mauve-cursors";

          input.touchpad.natural-scroll = false;

          gestures.hot-corners.enable = false;

          window-rules = [
            {
              matches = [
                {
                  app-id = "^zen-beta$";
                  title = "^Picture-in-Picture$";
                }
              ];
              open-floating = true;
            }
            {
              matches = [{app-id = "com.mitchellh.ghostty";}];
              draw-border-with-background = false;
            }
          ];
        }
        // optionalAttrs (displays != []) {
          # [{ connector = "eDP-1"; resolution = { width = 1920; height = 1080; }; inch = 13.3; is_laptop = true; }] ->
          # outputs."eDP-1".scale = 1.3041898142341162;
          outputs = mkMerge (map mkNiriDisplayOutputs displays);
        };
    };

    # niri-flake doesn't expose blur-related schema yet, so append raw KDL after generation.
    xdg.configFile.niri-config.source = niriBlurPatch;
  };
}
