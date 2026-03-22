{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.niri;
in {
  imports = [
    inputs.niri-flake.nixosModules.niri
  ];
  options.optionalModules.nixos.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
  };
}
