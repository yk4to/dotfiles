{
  pkgs,
  inputs,
  config,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.modules.linux.gui-apps;
in {
  imports = mylib.scanPaths ./.;

  options.modules.linux.gui-apps = {
    enable = mkEnableOption "GUI Applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      slack
    ];
  };
}
