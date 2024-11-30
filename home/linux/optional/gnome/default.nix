{
  pkgs,
  inputs,
  config,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.modules.linux.gnome;
in {
  imports = mylib.scanPaths ./.;

  options.modules.linux.gnome = {
    enable = mkEnableOption "GNOME Desktop Environment";
  };

  config = mkIf cfg.enable {
    dconf.settings = {
      "org/gnome/shell".favorite-apps = [
        (
          if config.modules.linux.gui-apps.enable
          then "firefox-devedition.desktop"
          else null
        )
        "code.desktop"
        (
          if config.modules.base.ghostty.enable
          then "com.mitchellh.ghostty.desktop"
          else "org.gnome.Terminal.desktop"
        )
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
  };
}
