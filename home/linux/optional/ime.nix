{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  guiEnabled = config.optionalModules.linux.gnome.enable || config.optionalModules.linux.niri.enable;
in {
  imports = [inputs.nix-hazkey.homeModules.hazkey];

  config = mkIf guiEnabled {
    services.hazkey.enable = true;

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;

        # Preconfigure Hazkey in the Fcitx profile.
        settings.inputMethod = {
          GroupOrder = {
            "0" = "Default";
          };
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "hazkey";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };
          "Groups/0/Items/1" = {
            Name = "hazkey";
            Layout = "";
          };
        };
      };
    };
  };
}
