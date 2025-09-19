{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.host {
  name = "raspi4";

  system = "aarch64-linux";

  nixos = {myconfig, ...}: {
    imports = with inputs.nixos-hardware.nixosModules; [
      raspberry-pi-4
    ];

    networking.hostName = "raspi4";

    # Enable automatic login
    # ref: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = myconfig.constants.username;
    # systemd.services."getty@tty1".enable = false;
    # systemd.services."autovt@tty1".enable = false;

    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

      loader = {
        grub.enable = false;
        generic-extlinux-compatible.enable = true;
      };

      # initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    };

    fileSystems = {
      "/boot" = {
        device = "/dev/disk/by-label/FIRMWARE";
        fsType = "vfat";
      };
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
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

    system.stateVersion = "25.11";
  };
}
