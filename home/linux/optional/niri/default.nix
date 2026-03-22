{
  config,
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
    programs.niri.settings ={
      outputs."eDP-1".scale = 1.1;

      input.touchpad.natural-scroll = false;

      window-rules = [
        {
          matches = [{
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          }];
          open-floating = true;
        }
      ];
    };
  };
}
