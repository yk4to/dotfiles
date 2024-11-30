{
  inputs,
  system,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.ghostty;
in {
  options.optionalModules.nixos.ghostty = {
    enable = mkEnableOption "Ghostty terminal emulator";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.ghostty.packages.${system}.default
    ];
  };
}
