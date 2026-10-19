{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.niri;

  noctalia = cmd:
    [
      "noctalia"
      "msg"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in {
  config = mkIf cfg.enable {
    wayland.windowManager.niri.settings = {
      binds = {
        "Mod+Shift+Slash".show-hotkey-overlay = {};

        "Mod+W" = {
          _props.repeat = false;
          close-window = {};
        };

        "Mod+Left".focus-column-left = {};
        "Mod+Down".focus-window-down = {};
        "Mod+Up".focus-window-up = {};
        "Mod+Right".focus-column-right = {};

        "Mod+Ctrl+Left".move-column-left = {};
        "Mod+Ctrl+Down".move-window-down = {};
        "Mod+Ctrl+Up".move-window-up = {};
        "Mod+Ctrl+Right".move-column-right = {};

        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;
        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;

        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";

        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";

        "Mod+V".toggle-window-floating = {};
        "Mod+Shift+V".switch-focus-between-floating-and-tiling = {};

        "Mod+Space".spawn = noctalia "panel-toggle launcher";
        "Mod+S".spawn = noctalia "panel-toggle control-center";
        "Mod+Comma".spawn = noctalia "settings-toggle";

        "XF86AudioLowerVolume".spawn = noctalia "volume-down";
        "XF86AudioRaiseVolume".spawn = noctalia "volume-up";
        "XF86AudioMute".spawn = noctalia "volume-mute";
        "XF86MonBrightnessUp".spawn = noctalia "brightness-up";
        "XF86MonBrightnessDown".spawn = noctalia "brightness-down";
      };
    };
  };
}
