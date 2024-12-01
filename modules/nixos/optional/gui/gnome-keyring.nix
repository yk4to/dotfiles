{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.gui.enable {
    services.gnome.gnome-keyring.enable = true;
    environment.systemPackages = [pkgs.libsecret];
    security.pam.services.gdm.enableGnomeKeyring = true;
    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
    programs.seahorse.enable = true;
  };
}
