{
  config,
  inputs,
  lib,
  mylib,
  system,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.niri;
in {
  imports = mylib.scanPaths ./.;

  options.optionalModules.linux.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable (let
    niriPkgs = inputs.niri-flake.packages.${system};
    xwaylandSatellite = niriPkgs.xwayland-satellite-unstable;
  in {
    programs.niri = {
      package = niriPkgs.niri-unstable;
      settings = {
        xwayland-satellite = {
          enable = true;
          path = getExe xwaylandSatellite;
        };

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
  });
}
