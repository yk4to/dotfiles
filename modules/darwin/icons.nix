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
      {
        path = "/Applications/Blackmagic RAW/Blackmagic RAW Player.app/";
        icon = ../../icons/rawplayer.icns;
      }
      {
        path = "/Applications/Blackmagic RAW/Blackmagic RAW Speed Test.app/";
        icon = ../../icons/rawspeedtest.icns;
      }
    ];
  };
}