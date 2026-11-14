{
  lib,
  config,
  osConfig,
  ...
}: let
  # Installed system-wide by the NixOS catppuccin cursors port
  cursors = osConfig.catppuccin.cursors;
in {
  config = lib.mkIf config.optionalModules.linux.gnome.enable {
    dconf.settings."org/gnome/desktop/interface".cursor-theme = "catppuccin-${cursors.flavor}-${cursors.accent}-cursors";

    # The icon theme comes from the catppuccin gtk.icon port
    gtk = {
      enable = true;
      colorScheme = "dark";
      gtk4.theme = config.gtk.theme;
    };
  };
}
