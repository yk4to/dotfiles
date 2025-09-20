{delib, ...}:
delib.module {
  name = "programs.hyprland";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.hyprland.enable = true;

    # Enable swaylock for hyprland
    security.pam.services.swaylock = {};
  };

  home.ifEnabled.wayland.windowManager.hyprland.enable = true;
}
