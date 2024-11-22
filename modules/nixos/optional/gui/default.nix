{mylib, ...}: {
  imports = mylib.scanPaths ./.;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable gdm (GNOME Display Manager)
  services.xserver.displayManager.gdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
