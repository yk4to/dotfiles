{
  pkgs,
  inputs,
  config,
  lib,
  mylib,
  ...
} @ args:
with lib; let
  cfg = config.modules.linux.gui-apps;
in {
  options.modules.linux.gui-apps = {
    enable = mkEnableOption "GUI Applications";
  };

  config = mkIf cfg.enable (
    mkMerge ([
        {
          home.packages = with pkgs; [
            discord
            slack
          ];
        }
      ]
      ++ (map (path: import path args) (mylib.scanPaths ./.)))
  );
}
