{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, C, exec, code"
        "$mod, g, exec, ghostty --window-decoration=false"
      ];
    };
  };
}