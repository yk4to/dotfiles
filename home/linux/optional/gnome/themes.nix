{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.gnome.enable {
    home.packages = with pkgs; [
      yaru-theme
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = "Yaru";
        gtk-theme = "Yaru-blue-dark";
        icon-theme = "Yaru-blue";
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;

      iconTheme = {
        package = pkgs.yaru-theme;
        name = "Yaru-blue";
      };

      theme = {
        package = pkgs.yaru-theme;
        name = "Yaru-blue-dark";
      };

      gtk3.extraConfig = {
        gtk-icon-theme-name = "Yaru";
        gtk-theme-name = "Yaru-blue-dark";
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
