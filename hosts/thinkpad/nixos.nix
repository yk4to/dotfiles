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
      ../../modules/nixos/optional/hyprland
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-gpu-nvidia
      common-pc-ssd
    ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.userfullname;
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  networking.hostName = "thinkpad";

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      extraInstallCommands = "echo 'default @saved' > /boot/loader/loader.conf";
    };

    efi.canTouchEfiVariables = true;
  };

  # Enable graphical splash screen
  boot.plymouth.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # set hardware clock in local time to prevent Windows clock from going wrong
  time.hardwareClockInLocalTime = true;

  system.stateVersion = "23.11";

  # set config about nvidia gpu
  hardware.nvidia = {
    open = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:3:0:0";
    };
  };
}
