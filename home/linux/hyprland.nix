{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, C, exec, code --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto"
        "$mod, g, exec, ghostty --window-decoration=false"
      ];

      monitor = "eDP-1, 2880x1800@90, 0x0, 1.8";
    };
  };
}