{
  inputs,
  pkgs,
  vars,
  ...
}: {
  imports =
    [
      ../../modules/nixos
      ../../modules/nixos/optional/gui
      ../../modules/nixos/optional/gnome.nix
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

      # Enable audio
      audio.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  system.stateVersion = "23.11";
}
