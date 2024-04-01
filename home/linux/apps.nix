{ pkgs, ... }: {
  # install vscode in this way instead of using `programs`
  # to use `sync settings`
  home.packages = with pkgs; [
    vscode
  ];

  programs = {
    google-chrome.enable = true;

    wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require("wezterm")
        local config = {
          font = wezterm.font("UDEV Gothic 35NFLG"),
          font_size = 13.0,
          color_scheme = "OneHalfDark",
          -- use_fancy_tab_bar = false,
          -- freetype_load_target = "Light",
          -- window_background_opacity = 0.95,
          hide_tab_bar_if_only_one_tab = true,
          -- window_decorations = "RESIZE",
          window_padding = {
            left = 14,
            right = 14,
            top = 14, -- 54
            bottom = 14,
          },
        }
        return config
      '';
    }
  };
}
