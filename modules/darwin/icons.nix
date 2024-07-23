{vars, ...}: let
  icloudPath = "/Users/${vars.username}/Library/Mobile Documents/com~apple~CloudDocs";
  iconsPath = "${icloudPath}/icons";
in {
  # ref: https://github.com/ryanccn/nix-darwin-custom-icons
  environment.customIcons = {
    enable = true;
    icons = [
      {
        path = "/Applications/AltTab.app";
        icon = "${iconsPath}/alttab.icns";
      }
      {
        path = "/Applications/KeyboardCleanTool.app/";
        icon = "${iconsPath}/keyboardcleantool.icns";
      }
      {
        path = "/Applications/Blackmagic RAW/Blackmagic RAW Player.app/";
        icon = "${iconsPath}/rawplayer.icns";
      }
      {
        path = "/Applications/Blackmagic RAW/Blackmagic RAW Speed Test.app/";
        icon = "${iconsPath}/rawspeedtest.icns";
      }
      {
        path = "/Applications/Google Docs.app/";
        icon = "${iconsPath}/googledocs.icns";
      }
      {
        path = "/Applications/Google Sheets.app/";
        icon = "${iconsPath}/googlesheets.icns";
      }
      {
        path = "/Applications/Google Slides.app/";
        icon = "${iconsPath}/googleslides.icns";
      }
      {
        path = "/Applications/Box.app/";
        icon = "${iconsPath}/box.icns";
      }
      {
        path = "/Applications/F5 VPN.app/";
        icon = "${iconsPath}/f5vpn.icns";
      }
      {
        path = "/Applications/Raspberry Pi Imager.app/";
        icon = "${iconsPath}/raspi.icns";
      }
      {
        path = "/Applications/MATLAB_R2024a.app/";
        icon = "${iconsPath}/matlab.icns";
      }
      {
        path = "/Applications/KiCad/KiCad.app/";
        icon = "${iconsPath}/kicad.icns";
      }
    ];
  };
}
