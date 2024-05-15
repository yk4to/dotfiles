{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.kimpanel
    yaru-theme
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.wezfurlong.wezterm.desktop"
        "org.gnome.Nautilus.desktop"
      ];

      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "kimpanel@kde.org"
      ];
    };

    "org/gnome/mutter" = {
      # Enable fractional scaling
      experimental-features = ["scale-monitor-framebuffer"];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/desktop/interface" = {
      cursor-theme = "Yaru";
      gtk-theme = "Yaru-dark";
      icon-theme = "Yaru";
      color-scheme = "prefer-dark";
      
      gtk-im-module = "fcitx";

      show-battery-percentage = true;
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

    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru";
    };

    theme = {
      package = pkgs.yaru-theme;
      name = "Yaru-dark";
    };

    gtk3.extraConfig = {
      gtk-icon-theme-name = "Yaru";
      gtk-theme-name = "Yaru-dark";
      gtk-application-prefer-dark-theme = 1;
    };
  };
}