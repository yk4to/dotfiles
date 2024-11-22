{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.paperwm
    gnomeExtensions.dash-to-dock
    gnomeExtensions.kimpanel
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      "paperwm@paperwm.github.com"
      "dash-to-dock@micxgx.gmail.com"
      "kimpanel@kde.org"
    ];

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
