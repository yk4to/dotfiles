{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.hyprland;
in {
  options.optionalModules.nixos.hyprland = {
    enable = mkEnableOption "Hyprland window manager";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    # Enable swaylock for hyprland
    security.pam.services.swaylock = {};
  };
}
