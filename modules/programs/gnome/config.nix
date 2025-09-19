{
  delib,
  lib,
  ...
}:
delib.module {
  name = "programs.gnome";

  home.ifEnabled = {myconfig, ...}: {
    dconf.settings = {
      "org/gnome/shell".favorite-apps =
        (
          lib.optionals myconfig.programs.firefox.enable
          ["firefox-devedition.desktop"]
        )
        ++ (
          if myconfig.programs.ghostty.enable
          then ["com.mitchellh.ghostty.desktop"]
          else ["org.gnome.Console.desktop"]
        )
        ++ (
          lib.optionals myconfig.programs.vscode.enable
          ["code.desktop"]
        )
        ++ (
          lib.optionals myconfig.programs.apps.enable [
            "discord.desktop"
            "slack.desktop"
            "todoist.desktop"
          ]
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
