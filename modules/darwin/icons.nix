{
  inputs,
  vars,
  ...
}: let
  icloudPath = "/Users/${vars.username}/Library/Mobile Documents/com~apple~CloudDocs";
  iconsPath = "${icloudPath}/icons";
in {
  imports = [
    inputs.darwin-custom-icons.darwinModules.default
  ];

  # ref: https://github.com/ryanccn/nix-darwin-custom-icons
  environment.customIcons = {
    enable = true;
    icons = [
      {
        path = "/Applications/Blackmagic RAW/Blackmagic RAW Player.app/";
        icon = "${iconsPath}/rawplayer.icns";
      }
      {
        path = "/Applications/Blackmagic RAW/Blackmagic RAW Speed Test.app/";
        icon = "${iconsPath}/rawspeedtest.icns";
      }
      {
        path = "/Applications/KiCad/KiCad.app/";
        icon = "${iconsPath}/kicad.icns";
      }
      {
        path = "/Applications/Creality Print.app/";
        icon = "${iconsPath}/crealityprint.icns";
      }
      {
        path = "/Applications/FlashPrint 5.app/";
        icon = "${iconsPath}/flashprint.icns";
      }
      {
        path = "/Applications/Notion.app/";
        icon = "${iconsPath}/notion.icns";
      }
    ];
  };
}
