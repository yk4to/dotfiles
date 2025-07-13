{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.gui-apps.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require("wezterm")
        local config = {
          font = wezterm.font("UDEV Gothic 35NFLG"),
          font_size = 10.0,
          color_scheme = "OneHalfDark",
          use_fancy_tab_bar = true,
          -- freetype_load_target = "Light",
          window_background_opacity = 0.95,
          hide_tab_bar_if_only_one_tab = true,
          hide_mouse_cursor_when_typing = false,
          window_padding = {
            left = 14,
            right = 14,
            top = 14, -- 54
            bottom = 14,
          },
        }
        return config
      '';
    };
  };
}
