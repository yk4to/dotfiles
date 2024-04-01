{
  # ref: https://github.com/ryanccn/nix-darwin-custom-icons
  environment.customIcons = {
    enable = true;
    icons = [
      {
        path = "/Applications/AltTab.app";
        icon = ../../icons/alttab.icns;
      }
      {
        path = "/Applications/KeyboardCleanTool.app/";
        icon = ../../icons/keyboardcleantool.icns;
      }
    ];
  };
}