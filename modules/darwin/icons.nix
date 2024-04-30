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
      {
        path = "/Applications/Google Docs.app/";
        icon = ../../icons/googledocs.icns;
      }
      {
        path = "/Applications/Google Sheets.app/";
        icon = ../../icons/googlesheets.icns;
      }
      {
        path = "/Applications/Google Slides.app/";
        icon = ../../icons/googleslides.icns;
      }
      {
        path = "/Applications/Box.app/";
        icon = ../../icons/box.icns;
      }
      {
        path = "/Applications/F5 VPN.app/";
        icon = ../../icons/f5vpn.icns;
      }
      {
        path = "/Applications/Raspberry Pi Imager.app/";
        icon = ../../icons/raspi.icns;
      }
      {
        path = "/Applications/MATLAB_R2024a.app/";
        icon = ../../icons/matlab.icns;
      }
    ];
  };
}