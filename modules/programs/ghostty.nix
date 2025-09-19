{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.ghostty";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.programs.ghostty = {
    enable = true;

    # on macOS, use a mock package since the ghostty pkg is broken
    # use Nix only for deploying configuration files; install binaries via Homebrew
    package =
      if pkgs.stdenv.isDarwin
      then null
      else pkgs.ghostty;

    enableFishIntegration = true;

    settings = {
      font-family = [
        "JetBrainsMono Nerd Font"
        "UDEV Gothic 35LG"
      ];

      font-thicken = true;

      theme = "Atom One Dark";

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
