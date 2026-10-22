{inputs, ...}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-pc-ssd
    ]);

  optionalModules.nixos = {
    nextdns.enable = true;
    services.enable = true;
    tailscale.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # The Wi-Fi adapter (TP-Link Archer T2U Plus, RTL8821AU) is handled by the
  # in-tree rtw88 driver (`rtw_8821au`) since Linux 6.13; no out-of-tree module needed.
}
