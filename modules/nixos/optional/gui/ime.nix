{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nix-hazkey.nixosModules.hazkey];

  config = lib.mkIf config.optionalModules.nixos.gui.enable {
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
