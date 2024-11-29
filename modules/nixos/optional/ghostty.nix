{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.ghostty;
in {
  options.modules.nixos.ghostty = {
    enable = mkEnableOption "Ghostty terminal emulator";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.ghostty.packages.${system}.default
    ];
  };
}
