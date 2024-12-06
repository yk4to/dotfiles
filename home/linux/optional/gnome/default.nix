{
  config,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.gnome;
in {
  imports = mylib.scanPaths ./.;

  options.optionalModules.linux.gnome = {
    enable = mkEnableOption "GNOME Desktop Environment";
  };

  config = mkIf cfg.enable {
    dconf.settings = {
      "org/gnome/shell".favorite-apps =
        (
          if config.optionalModules.linux.gui-apps.enable
          then [
            "firefox-devedition.desktop"
          ]
          else []
        )
        ++ (
          if config.optionalModules.base.ghostty.enable
          then ["com.mitchellh.ghostty.desktop"]
          else ["org.gnome.Terminal.desktop"]
        )
        ++ (
          if config.optionalModules.base.vscode.enable
          then ["code.desktop"]
          else []
        )
        ++ (
          if config.optionalModules.linux.gui-apps.enable
          then [
            "discord.desktop"
            "slack.desktop"
            "todoist.desktop"
          ]
          else []
        )
        ++ [
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
