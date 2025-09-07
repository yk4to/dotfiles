{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
with lib; let
  cfg = config.optionalModules.base.ghostty;
in {
  options.optionalModules.base.ghostty = {
    enable = mkEnableOption "Ghostty";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      # on macOS, use a mock package since the ghostty pkg is broken
      # use Nix only for deploying configuration files; install binaries via Homebrew
      package =
        if isDarwin
        then null
        else pkgs.ghostty;

      enableFishIntegration = true;

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
        window-padding-color = "extend";

        keybind = "global:ctrl+escape=toggle_quick_terminal";
      };
    };
  };
}
