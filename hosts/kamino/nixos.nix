{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    inputs.disko.nixosModules.disko
  ];

  optionalModules.nixos = {
    # docker.enable = true;
    # wsl.enable = true;
    tailscale.enable = true;
    # vscode-server.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    initrd.systemd.enable = true;
  };

  services.openssh = {
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
