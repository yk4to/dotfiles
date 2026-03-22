{
  config,
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
    programs.niri.settings = let
      noctalia = cmd:
        [
          "noctalia-shell"
          "ipc"
          "call"
        ]
        ++ (pkgs.lib.splitString " " cmd);
    in {
      binds = {
        "Mod+Space".action.spawn = noctalia "launcher toggle";
        "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
        "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
      };

      outputs."eDP-1".scale = 1.1;

      input.touchpad.natural-scroll = false;
    };
  };
}
