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
      lenovo-thinkpad-x230
    ];

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

    boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/cf3e2d98-00c2-40b6-bea5-6763a79e106b";
      fsType = "ext4";
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/e500aeef-759f-486a-a7c5-3aaacb944c27";}
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault myconfig.nixos.hardware.enableRedistributableFirmware;

    system.stateVersion = "25.05";
  };

  home.home.stateVersion = "25.05";
}
