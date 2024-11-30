{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.base.ghostty;
in {
  options.modules.base.ghostty = {
    enable = mkEnableOption "Ghostty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      shellIntegration.enable = false;
      shellIntegration.enableFishIntegration = true;

      settings = {
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

        keybind = "global:ctrl+escape=toggle_quick_terminal";
      };
    };
  };
}
