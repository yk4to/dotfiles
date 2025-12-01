{inputs, ...}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      lenovo-thinkpad-x230
    ]);

  optionalModules.nixos = {
    gui.enable = true;
    secureboot.enable = false;
    tailscale.enable = true;
    hyprland.enable = true;
  };

  networking.hostName = "x230";

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
    timeoutStyle = "hidden";
    default = "saved";
  };

  # Enable graphical splash screen
  boot.plymouth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # set hardware clock in local time to prevent Windows clock from going wrong
  time.hardwareClockInLocalTime = true;

  # Force i965 on X230 (Ivy Bridge) to avoid Mesa misdetection that breaks Ghostty.
  environment.variables = {
    MESA_LOADER_DRIVER_OVERRIDE = "i965";
  };

  system.stateVersion = "25.05";
}
