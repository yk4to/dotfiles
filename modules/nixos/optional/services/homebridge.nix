{
  lib,
  config,
  vars,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    virtualisation.oci-containers.containers.homebridge = {
      image = "docker.io/homebridge/homebridge:latest";
      volumes = ["/var/lib/homebridge:/homebridge"];
      environment = {
        "TZ" = vars.timeZone;
        "HOMEBRIDGE_CONFIG_UI" = "1";
        "HOMEBRIDGE_CONFIG_UI_PORT" = "8581";
      };
      extraOptions = ["--network=host"];
    };

    networking.firewall.allowedTCPPorts = [8581];
  };
}
