{
  inputs,
  lib,
  config,
  hostName,
  ...
}: {
  imports = [
    inputs.hoshiimo.nixosModules.default
  ];

  config = lib.mkIf config.optionalModules.nixos.services.enable {
    services.hoshiimo = {
      enable = true;
      host = "0.0.0.0";
      port = 4001;
      appUrl = "http://${hostName}.local:4001";
      openFirewall = true;
    };
  };
}
