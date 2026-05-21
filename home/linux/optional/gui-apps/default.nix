{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.gui-apps;
in {
  options.optionalModules.linux.gui-apps = {
    enable = mkEnableOption "GUI Applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      slack

      todoist-electron
    ];
  };
}
