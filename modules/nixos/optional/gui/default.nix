{
  config,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.gui;
in {
  imports = mylib.scanPaths ./.;

  options.optionalModules.nixos.gui = {
    enable = mkEnableOption "Generic GUI Settings";
  };

  config = mkIf cfg.enable {
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
  };
}
