{
  inputs,
  vars,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      lenovo-thinkpad-x230
    ]);

  optionalModules.nixos = {
    gui.enable = true;
    ghostty.enable = true;
    secureboot.enable = false;
    tailscale.enable = true;
  };

  networking.hostName = "x230";

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Enable graphical splash screen
  boot.plymouth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # set hardware clock in local time to prevent Windows clock from going wrong
  time.hardwareClockInLocalTime = true;

  system.stateVersion = "25.05";
}
