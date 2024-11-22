{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs.gnomeExtensions; [
    pop-shell # tiling window manager
    dash-to-dock # dock used in Ubuntu
    kimpanel # show ime status on menu bar
    appindicator # show indicator icons on menu bar
    logo-menu
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      "pop-shell@system76.com"
      "dash-to-dock@micxgx.gmail.com"
      "kimpanel@kde.org"
      "appindicatorsupport@rgcjonas.gmail.com"
      "logomenu@aryan_k"
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
      menu-button-terminal = "ghostty";
      hide-softwarecentre = true;
    };
  };
}
