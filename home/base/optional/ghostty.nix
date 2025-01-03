# ref: https://github.com/nix-community/home-manager/blob/master/modules/programs/ghostty.nix
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.optionalModules.base.ghostty;

  keyValueSettings = {
    listsAsDuplicateKeys = true;
    mkKeyValue = lib.generators.mkKeyValueDefault {} " = ";
  };
  keyValue = pkgs.formats.keyValue keyValueSettings;
in {
  options.optionalModules.base.ghostty = {
    enable = mkEnableOption "Ghostty";
  };

  config = mkIf cfg.enable {
    # NOTE: sey up manually not to manage ghostty package in home-manager

    # enable shell integration for fish
    programs.fish.interactiveShellInit = ''
      if set -q GHOSTTY_RESOURCES_DIR
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
      end
    '';

    # generate config file
    xdg.configFile."ghostty/config".source = keyValue.generate "ghostty-config" {
      font-family = [
        "JetBrainsMono Nerd Font"
        "UDEV Gothic 35LG"
      ];

      font-thicken = true;

      theme = "OneHalfDark";

      # macos-titlebar-style = "tabs";
      macos-window-shadow = false;

      background-opacity = 0.95;
      background-blur-radius = 20;

      window-padding-balance = true;
      window-padding-color = "extend";

      keybind = "global:ctrl+escape=toggle_quick_terminal";
    };
  };
}
