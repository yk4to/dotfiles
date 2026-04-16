{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.rss-generator.nixosModules.default
  ];

  config = lib.mkIf config.optionalModules.nixos.services.enable {
    services.rss-generator = {
      enable = true;
      port = 4000;
      openFirewall = true;
    };
  };
}
