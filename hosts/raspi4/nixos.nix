{
  inputs,
  pkgs,
  vars,
  ...
}: let
  # Get this file in a hacky way because it is included in the raspi kernel repository under GPL 2.0 license
  gpioFanOverlay = pkgs.fetchurl {
    url = "https://github.com/raspberrypi/linux/raw/rpi-6.6.y/arch/arm/boot/dts/overlays/gpio-fan-overlay.dts";
    sha256 = "35cc89362d0ebeb584c67024ca6bdc1be357921550e3568e1ad41d9000f61b42";
  };
  gpioFanOverlayContent =
    builtins.replaceStrings
    ["<&gpio 12 0>" "temperature = <55000>;"]
    ["<&gpio 18 0>" "temperature = <65000>;"]
    (builtins.readFile gpioFanOverlay);
in {
  imports =
    [
      ../../modules/nixos
      ../../modules/nixos/optional/gui
      ../../modules/nixos/optional/gnome.nix
      ../../modules/nixos/optional/services
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      raspberry-pi-4
      common-pc-ssd
    ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.userfullname;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };

  networking.hostName = "raspi4";

  # Enable ssh
  services.openssh.enable = true;

  # Enable mDNS
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  hardware = {
    raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;

      # Enable GPU acceleration
      fkms-3d.enable = true;

      # Enable audio (NOT WORKING)
      # ref: https://github.com/NixOS/nixos-hardware/issues/703
      # audio.enable = true;
    };

    # Enable fan control
    deviceTree.overlays = [
      {
        name = "gpio-fan";
        dtsText = gpioFanOverlayContent;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  system.stateVersion = "23.11";
}
