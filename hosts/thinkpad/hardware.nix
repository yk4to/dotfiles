{
  delib,
  lib,
  inputs,
  ...
}:
delib.host {
  name = "thinkpad";

  system = "x86_64-linux";

  nixos = {myconfig, ...}: {
    imports = with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-gpu-nvidia
      common-pc-ssd
    ];

    system.stateVersion = "23.11";

    networking.hostName = "thinkpad";

    # Bootloader.
    # NOTE: This is replaced by the secureboot module.
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

    # set config about nvidia gpu
    hardware.nvidia = {
      open = true;

      # ref: https://github.com/NixOS/nixpkgs/issues/353990
      package = myconfig.nixos.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:3:0:0";
      };
    };

    boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/1e18f055-70d0-49cb-a3c3-f8f7f43b1c00";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/AC70-3584";
      fsType = "vfat";
    };

    swapDevices = [];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

    hardware.cpu.intel.updateMicrocode = lib.mkDefault myconfig.nixos.hardware.enableRedistributableFirmware;
  };

  home.home.stateVersion = "23.11";
}
