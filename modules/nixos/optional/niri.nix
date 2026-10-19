{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.niri;
in {
  options.optionalModules.nixos.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
  };
}
