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

      macos-titlebar-tabs = true;

      background-opacity = 0.98;
      background-blur-radius = 15;

      window-padding-balance = true;
    };
  };
}
