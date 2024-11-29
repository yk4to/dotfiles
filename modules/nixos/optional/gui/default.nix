{
  pkgs,
  inputs,
  config,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.gui;
in {
  options.modules.nixos.gui = {
    enable = mkEnableOption "Generic GUI Settings";
  };

  config = mkIf cfg.enable (mkMerge (map
      (f: import f {inherit pkgs lib config;})
      (mylib.scanPaths ./.))
    ++ [
      {
        # Enable the X11 windowing system.
        services.xserver.enable = true;

        # Enable gdm (GNOME Display Manager)
        services.xserver.displayManager.gdm.enable = true;

        # Enable GNOME
        services.xserver.desktopManager.gnome.enable = true;

        # Configure keymap in X11
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };
      }
    ]);
}
