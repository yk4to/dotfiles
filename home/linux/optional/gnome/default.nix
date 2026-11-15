{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.linux.gnome;
  gui-apps = config.optionalModules.linux.gui-apps.enable;
in {
  options.optionalModules.linux.gnome = {
    enable = mkEnableOption "GNOME Desktop Environment";
  };

  config = mkIf cfg.enable {
    dconf.settings = {
      "org/gnome/shell".favorite-apps =
        optionals gui-apps ["zen-beta.desktop"]
        ++ (
          if config.optionalModules.base.ghostty.enable
          then ["com.mitchellh.ghostty.desktop"]
          else ["org.gnome.Console.desktop"]
        )
        ++ optionals config.optionalModules.base.vscode.enable ["code.desktop"]
        ++ optionals gui-apps [
          "discord.desktop"
          "slack.desktop"
          "todoist.desktop"
        ]
        ++ ["org.gnome.Nautilus.desktop"];

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
