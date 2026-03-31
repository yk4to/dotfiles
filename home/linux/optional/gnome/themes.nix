{
  lib,
  config,
  ...
}: let
  flavor = "mocha";
  accent = "blue";
in {
  config = lib.mkIf config.optionalModules.linux.gnome.enable {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = "catppuccin-${flavor}-${accent}-cursors";
        # gtk-theme = "Yaru-blue-dark";
        icon-theme = "Papirus-Dark";
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;

      # iconTheme = {
      #   package = pkgs.yaru-theme;
      #   name = "Yaru-blue";
      # };

      # theme = {
      #   package = pkgs.yaru-theme;
      #   name = "Yaru-blue-dark";
      # };

      gtk3.extraConfig = {
        gtk-icon-theme-name = "Papirus-Dark";
        # gtk-theme-name = "Yaru-blue-dark";
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.theme = config.gtk.theme;
    };
  };
}
