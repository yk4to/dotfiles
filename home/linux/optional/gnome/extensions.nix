{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.gnome.enable {
    home.packages = with pkgs.gnomeExtensions; [
      pop-shell # tiling window manager
      dash-to-dock # dock used in Ubuntu
      kimpanel # show ime status on menu bar
      appindicator # show indicator icons on menu bar
      logo-menu
      caffeine # prevent screen from turning off
    ];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "pop-shell@system76.com"
        "dash-to-dock@micxgx.gmail.com"
        "kimpanel@kde.org"
        "appindicatorsupport@rgcjonas.gmail.com"
        "logomenu@aryan_k"
        "caffeine@patapon.info"
      ];

      "org/gnome/shell/extensions/pop-shell" = {
        tile-by-default = true;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "LEFT";
        autohide = false;
        autohide-in-fullscreen = false;
        extend-height = true;
        intellihide = false;

        apply-custom-theme = true;
        custom-theme-shrink = true;
      };

      "org/gnome/shell/extensions/Logo-menu" = {
        menu-button-icon-image = 23;
        menu-button-icon-size = 23;
        menu-button-icon-click-type = 3;
        menu-button-terminal =
          if config.optionalModules.base.ghostty.enable
          then "ghostty"
          else "gnome-terminal";
        hide-softwarecentre = true;
      };
    };
  };
}
