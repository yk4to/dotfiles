{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.nextdns;
  isWsl = config.wsl.enable or false;
in {
  options.optionalModules.nixos.nextdns = {
    enable = mkEnableOption "NextDNS";
  };

  config = mkIf (cfg.enable && !isWsl) {
    services.nextdns = {
      enable = true;
      arguments = ["-config-file" "${config.age.secrets.nextdns.path}"];
    };

    networking.nameservers = [
      "127.0.0.1"
      "::1"
    ];

    age.secrets = {
      nextdns = {
        file = "${inputs.secrets}/nextdns.age";
        mode = "600";
      };
    };
  };
}
