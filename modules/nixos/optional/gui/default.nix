{
  imports = [
    ./apps.nix
    ./fonts.nix
    ./gnome-keyring.nix
    ./ime.nix
    ./sound.nix
  ];

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
