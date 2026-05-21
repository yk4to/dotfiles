{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.gui;
in {
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
