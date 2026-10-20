{inputs, ...}: {
  imports =
    [
      ./hardware-configuration.nix
      ./disk-config.nix
      inputs.disko.nixosModules.disko
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-amd
      common-cpu-amd-pstate
      common-pc
      common-pc-ssd
    ]);

  optionalModules.nixos = {
    docker.enable = true;
    gui.enable = true;
    niri.enable = true;
    nextdns.enable = true;
    nvidia.enable = true;
    openrgb.enable = true;
    tailscale.enable = true;
  };

  # Bootloader.
  # NOTE: This will be replaced by the secureboot module.
  boot.loader = {
    systemd-boot = {
      enable = true;
      extraInstallCommands = "echo 'default @saved' > /boot/loader/loader.conf";

      # Windows lives on a separate SSD with its own ESP, so systemd-boot cannot detect it.
      # Chainload it through the EFI shell instead.
      # TODO: After installation, boot "EFI Shell", run `map -c` and find the handle
      #   whose `ls <handle>:\EFI` shows `Microsoft`, then uncomment the entry below.
      # ref: https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows
      edk2-uefi-shell.enable = true;
      # windows."11" = {
      #   title = "Windows 11";
      #   efiDeviceHandle = "HD1b";
      # };
    };

    efi.canTouchEfiVariables = true;
  };

  # Enable graphical splash screen
  boot.plymouth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # set hardware clock in local time to prevent Windows clock from going wrong
  time.hardwareClockInLocalTime = true;

  # Run unpatched dynamic binaries such as VS Code Remote-SSH server.
  programs.nix-ld.enable = true;
}
