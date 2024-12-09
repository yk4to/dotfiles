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
    services.xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
}
