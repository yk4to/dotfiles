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
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  # Enable automatic login
  # ref: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = vars.username;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    # Enable fan control
    raspberrypi.config.all.dtoverlay = [
      "gpio-fan,gpiopin=18,temp=60000"
    ];
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
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  system.stateVersion = "23.11";
}
