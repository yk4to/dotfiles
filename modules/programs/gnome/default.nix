{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.gnome";

  options = delib.singleEnableOption (host.guiFeatured && pkgs.stdenv.isLinux);

  nixos.ifEnabled.services.desktopManager.gnome.enable = true;
}
