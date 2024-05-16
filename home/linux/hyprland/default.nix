{
  imports = [
    ./clamshell.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, C, exec, code --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto"
        "$mod, g, exec, ghostty --window-decoration=false"
      ];

      # TODO: move this config under `hosts` dir
      monitor = [
        "eDP-1, 2880x1800@90, 0x0, 1.8"
        "HDMI-A-1, 3840x2160@60, 0x0, 1.5"
      ];
    };
  };
}