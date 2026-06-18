{
  inputs,
  config,
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
    services.enable = true;
    tailscale.enable = true;
    vscode-server.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtw88 # realtek wifi driver
  ];
}
