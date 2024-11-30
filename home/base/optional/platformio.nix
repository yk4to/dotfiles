{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.base.platformio;
in {
  options.modules.base.platformio = {
    enable = mkEnableOption "PlatformIO";

    package = mkOption {
      type = types.package;
      default = pkgs.platformio;
      defaultText = literalExpression "pkgs.platformio";
      description = "PlatformIO package to install";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
