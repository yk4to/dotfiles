{
  imports = [
    ./apps.nix
    ./fonts.nix
    ./gnome-keyring.nix
    ./gnome.nix
    ./hyprland.nix
    ./ime.nix
    ./sound.nix

    ../base
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable gdm (GNOME Display Manager)
  services.xserver.displayManager.gdm.enable = true;

  # Enable swaylock for hyprland
  security.pam.services.swaylock = {};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
