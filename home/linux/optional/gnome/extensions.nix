{pkgs, ...}: {
  home.packages = with pkgs.gnomeExtensions; [
    pop-shell # tiling window manager
    dash-to-dock # dock used in Ubuntu
    kimpanel # show ime status
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      "pop-shell@system76.com"
      "dash-to-dock@micxgx.gmail.com"
      "kimpanel@kde.org"
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
  };
}
