{
  home.stateVersion = "25.05";

  optionalModules = {
    base = {
      ghostty.enable = true;
      # inkdrop.enable = true;
      # latex.enable = true;
      # platformio.enable = true;
      vscode.enable = true;
    };
    linux = {
      gnome.enable = true;
      niri.enable = true;
      gui-apps.enable = true;
    };
  };
}
