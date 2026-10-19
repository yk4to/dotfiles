{
  pkgs,
  config,
  lib,
  inputs,
  system,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.gui-apps;
in {
  options.optionalModules.linux.gui-apps = {
    enable = mkEnableOption "GUI Applications";
  };

  config = mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        discord
        slack

        todoist-electron

        parsec-bin
      ])
      # Official Linux builds, tracked more closely by llm-agents than nixpkgs.
      ++ (with inputs.llm-agents.packages.${system}; [
        chatgpt
        claude-desktop
      ]);
  };
}
