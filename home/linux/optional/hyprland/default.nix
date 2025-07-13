{mylib, ...}: {
  imports = mylib.scanPaths ./.;

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        # "GTK_IM_MODULE, fcitx"
        "QT_IM_MODULE, fcitx"
        "XMODIFIERS, @im=fcitx"
      ];

      exec-once = [
        "fcitx5"
        "swaync"
      ];

      "$mod" = "SUPER";

      bind = [
        "$mod, F, exec, firefox-devedition"
        "$mod, C, exec, code --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto"
        "$mod, G, exec, ghostty --window-decoration=false"

        "$mod, SPACE, exec, wofi --show drun"
        "$mod, L, exec, swaylock"

        "$mod, W, killactive"
      ];

      # TODO: move this config under `hosts` dir
      monitor = [
        "eDP-1, 1366x768@60, 0x0, 1.0"
        # "eDP-1, 2880x1800@90, 0x0, 1.8"
        # "HDMI-A-1, 3840x2160@60, 0x0, 1.5"
      ];

      # --- LOOK AND FEEL ---
      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;
        "col.active_border" = "rgba(56b6c2aa) rgba(61afefaa) 45deg";
        "col.inactive_border" = "rgba(5c6370aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # --- ANIMATION ---
      layerrule = "noanim, wofi";

      # --- INPUT ---
      input.follow_mouse = 2; # Clicking on a window will move keyboard focus to that window
    };
  };
}
