{inputs, ...}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      lenovo-thinkpad-x13-intel
    ]);

  optionalModules.nixos = {
    docker.enable = true;
    gui.enable = true;
    niri.enable = true;
    # tailscale.enable = true;
    vscode-server.enable = true;
  };

  networking.hostName = "x13";

  # Bootloader.
  # NOTE: This will be replaced by the secureboot module.
  boot.loader = {
    systemd-boot = {
      enable = true;
      extraInstallCommands = "echo 'default @saved' > /boot/loader/loader.conf";
    };

    efi.canTouchEfiVariables = true;
  };

  # Enable graphical splash screen
  boot.plymouth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # set hardware clock in local time to prevent Windows clock from going wrong
  time.hardwareClockInLocalTime = true;

  system.stateVersion = "25.05";
}
