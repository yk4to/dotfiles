{
  inputs,
  pkgs,
  vars,
  ...
}: {
  imports =
    [
      # ./fan-control.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      raspberry-pi-4
      # common-pc-ssd
    ]);

  optionalModules.nixos = {
    gui.enable = true;
    services.enable = false;
    # ghostty.enable = true;
    # secureboot.enable = true;
    tailscale.enable = true;
  };

  networking.hostName = "raspi4";

  # Enable automatic login
  # ref: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = vars.username;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    # initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];

    initrd.luks.devices.luksroot = {
      device = "42479f9e-559e-44c3-a05f-3989daf38fce";
      preLVM = true;
      allowDiscards = true;
    };
  };

  hardware.raspberry-pi."4" = {
    apply-overlays-dtmerge.enable = true;

    # Enable GPU acceleration
    fkms-3d.enable = true;

    # Enable audio (NOT WORKING)
    # ref: https://github.com/NixOS/nixos-hardware/issues/703
    # audio.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  system.stateVersion = "25.05";
}
