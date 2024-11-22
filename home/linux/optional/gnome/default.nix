{
  pkgs,
  mylib,
  ...
}: {
  imports = mylib.scanPaths ./.;

  dconf.settings = {
    "org/gnome/shell".favorite-apps = [
      "firefox-devedition.desktop"
      "code.desktop"
      "com.mitchellh.ghostty.desktop"
      "org.gnome.Nautilus.desktop"
    ];

    "org/gnome/mutter" = {
      # Enable fractional scaling
      experimental-features = ["scale-monitor-framebuffer"];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
  };
}
