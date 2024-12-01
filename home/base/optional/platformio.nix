{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.base.platformio;
in {
  options.optionalModules.base.platformio = {
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
