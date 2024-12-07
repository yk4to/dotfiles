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
        "/var/run/dbus:/var/run/dbus"
        "/var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket"
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
        51873 # Homebridge
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
