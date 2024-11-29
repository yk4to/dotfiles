{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.linux.gui-apps;
in {
  options.modules.linux.gui-apps = {
    enable = mkEnableOption "GUI Applications";
  };

  config = mkIf cfg.enable (mkMerge (map
      (f: import f {inherit pkgs lib config;})
      (mylib.scanPaths ./.))
    ++ [
      {
        home.packages = with pkgs; [
          discord
          slack
        ];
      }
    ]);
}
