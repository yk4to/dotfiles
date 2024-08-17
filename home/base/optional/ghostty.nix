{
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

      macos-titlebar-style = "tabs";
      macos-window-shadow = false;

      background-opacity = 0.95;
      background-blur-radius = 20;

      window-padding-balance = true;
    };
  };
}
