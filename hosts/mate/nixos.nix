{
  inputs,
  config,
  vars,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-pc-ssd
    ]);

  optionalModules.nixos = {
    # services.enable = true;
    tailscale.enable = true;
  };

  networking.hostName = "mate";

  # Enable automatic login
  # ref: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = vars.username;
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  boot.loader = {
    systemd-boot = {
      enable = true;
      extraInstallCommands = "echo 'default @saved' > /boot/loader/loader.conf";
    };

    efi.canTouchEfiVariables = true;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [rtl88xxau-aircrack];

  system.stateVersion = "25.05";
}
