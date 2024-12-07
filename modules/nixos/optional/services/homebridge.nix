{
  lib,
  config,
  vars,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/homebridge 0755 root root - -"
    ];

    virtualisation.oci-containers.containers.homebridge = {
      image = "docker.io/homebridge/homebridge:latest";
      volumes = [
        "/var/lib/homebridge:/homebridge"
      ];
      environment = {
        "TZ" = vars.timeZone;
        "HOMEBRIDGE_CONFIG_UI" = "1";
        "HOMEBRIDGE_CONFIG_UI_PORT" = "8581";
      };
      extraOptions = ["--network=host"];
    };

    networking.firewall = {
      allowedTCPPorts = [
        8581 # Homebridge Config UI
        51605 # Homebridge
      ];
      allowedTCPPortRanges = [
        {
          from = 50100;
          to = 50200;
        }
      ];
    };
  };
}
