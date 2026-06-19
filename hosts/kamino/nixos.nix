{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    inputs.disko.nixosModules.disko
  ];

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

  services.openssh.openFirewall = true;
}
