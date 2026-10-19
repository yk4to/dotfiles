{
  optionalModules = {
    base = {
      ghostty = {
        enable = true;
        disableWindowDecoration = true;
      };
      # TODO: Re-enable once nix-inkdrop is fixed (dist.inkdrop.app returns 403 for the pinned .deb).
      # inkdrop.enable = true;
      # latex.enable = true;
      # platformio.enable = true;
      vscode = {
        enable = true;
        useGnomeLibsecret = true;
      };
    };
    linux = {
      gnome.enable = true;
      niri.enable = true;
      gui-apps.enable = true;
    };
  };
}
